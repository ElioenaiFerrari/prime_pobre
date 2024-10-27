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
      conn =
        conn
        |> put_resp_content_type(movie.mime_type)
        |> send_chunked(:ok)

      HTTPoison.get(movie.video_url, [], stream_to: self())

      stream_video_chunks(conn)
    end
  end

  defp stream_video_chunks(conn) do
    receive do
      {:ok, %HTTPoison.AsyncChunk{chunk: chunk}} ->
        # Envia o chunk ao cliente
        case chunk(conn, chunk) do
          {:ok, conn} -> stream_video_chunks(conn)
          {:error, :closed} -> :ok
        end

      {:ok, %HTTPoison.AsyncEnd{}} ->
        # O stream chegou ao fim
        :ok

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
        # Um erro ocorreu, então termina a transmissão
        :ok

      _ ->
        # Ignora qualquer outra mensagem
        stream_video_chunks(conn)
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

  # def show(conn, %{"id" => id}) do
  #   movie = Movies.get_movie!(id)
  #   render(conn, :show, movie: movie)
  # end

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
