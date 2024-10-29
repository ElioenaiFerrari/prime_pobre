defmodule PrimePobreWeb.MovieController do
  use PrimePobreWeb, :controller

  alias PrimePobre.Movies
  alias PrimePobre.Movies.Movie

  action_fallback PrimePobreWeb.FallbackController

  def index(conn, _params) do
    movies = Movies.list_movies()
    render(conn, :index, movies: movies)
  end

  def stream(conn, %{"id" => id}) do
    with %Movie{} = movie <- Movies.get_movie!(id) do
      stream_video_chunks(conn, movie)
    end
  end

  defp stream_range(conn, path, start, length) do
    {:ok, file} = File.open(path, [:read, :binary])
    :file.position(file, start)

    # Envia o arquivo em blocos a partir do intervalo especificado
    Enum.reduce_while(0..(length - 1), conn, fn _, conn_acc ->
      case IO.binread(file, min(1_000_000, length)) do
        :eof ->
          {:halt, conn_acc}

        {:error, _} ->
          {:halt, conn_acc}

        chunk ->
          case Plug.Conn.chunk(conn_acc, chunk) do
            {:ok, conn} -> {:cont, conn}
            {:error, _} -> {:halt, conn_acc}
          end
      end
    end)

    File.close(file)
    conn
  end

  defp parse_range(range, file_size) do
    [start_str, end_str] = String.split(range, "-")
    start = String.to_integer(start_str)
    end_pos = if end_str == "", do: file_size - 1, else: String.to_integer(end_str)
    {start, min(end_pos, file_size - 1)}
  end

  @media_dir "priv/static"
  defp stream_video_chunks(
         conn,
         %Movie{
           source: "file",
           media: media
         } = movie
       ) do
    path = Path.join(@media_dir, media)

    if File.exists?(path) do
      file_size = File.stat!(path).size
      range_header = get_req_header(conn, "range")

      # Se existir um cabeçalho "Range", processa o intervalo solicitado
      conn =
        case range_header do
          ["bytes=" <> range] ->
            {start, end_pos} = parse_range(range, file_size)
            length = end_pos - start + 1

            # Configura os cabeçalhos de resposta para streaming parcial
            conn
            |> put_resp_header("content-type", movie.mime_type)
            |> put_resp_header("content-length", Integer.to_string(length))
            |> put_resp_header("content-range", "bytes #{start}-#{end_pos}/#{file_size}")
            |> send_chunked(:partial_content)
            |> stream_range(path, start, length)

          _ ->
            # Responde com o vídeo completo se não houver "Range"
            conn
            |> put_resp_header("content-type", movie.mime_type)
            |> put_resp_header("content-length", Integer.to_string(file_size))
            |> send_chunked(:ok)
            |> stream_range(path, 0, file_size)
        end

      conn
    else
      send_resp(conn, 404, "File not found")
    end
  end

  defp stream_video_chunks(
         conn,
         %Movie{
           source: "remote",
           media: media
         } = movie
       ) do
    conn =
      conn
      |> put_resp_content_type(movie.mime_type)
      |> send_chunked(:ok)

    HTTPoison.get!(media, [], stream_to: self())

    receive do
      %HTTPoison.AsyncChunk{chunk: chunk} ->
        # Envia o chunk ao cliente
        case chunk(conn, chunk) do
          {:ok, conn} -> stream_video_chunks(conn, movie)
          {:error, :closed} -> :ok
        end

      %HTTPoison.AsyncEnd{} ->
        # O stream chegou ao fim
        :ok

      %HTTPoison.Error{reason: _reason} ->
        # Um erro ocorreu, então termina a transmissão
        :ok

      _ ->
        # Ignora qualquer outra mensagem
        stream_video_chunks(conn, movie)
    after
      # Timeout de 5 segundos
      5_000 -> :ok
    end
  end

  # def create(conn, %{"movie" => movie_params}) do
  #   with {:ok, %Movie{} = movie} <- Movies.create_movie(movie_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/movies/#{movie}")
  #     |> render(:show, movie: movie)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    movie = Movies.get_movie!(id)
    render(conn, :show, movie: movie)
  end

  # def update(conn, %{"id" => id, "movie" => movie_params}) do
  #   movie = Movies.get_movie!(id)

  #   with {:ok, %Movie{} = movie} <- Movies.update_movie(movie, movie_params) do
  #     render(conn, :show, movie: movie)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   movie = Movies.get_movie!(id)

  #   with {:ok, %Movie{}} <- Movies.delete_movie(movie) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
