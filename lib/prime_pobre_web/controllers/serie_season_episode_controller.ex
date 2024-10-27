defmodule PrimePobreWeb.SerieSeasonEpisodeController do
  use PrimePobreWeb, :controller

  alias PrimePobre.Repo
  alias PrimePobre.SerieSeasonEpisodes
  alias PrimePobre.SerieSeasonEpisodes.SerieSeasonEpisode

  action_fallback PrimePobreWeb.FallbackController

  def index(conn, _params) do
    serie_season_episodes = SerieSeasonEpisodes.list_serie_season_episodes()
    render(conn, :index, serie_season_episodes: serie_season_episodes)
  end

  def stream(conn, %{"id" => id}) do
    with %SerieSeasonEpisode{} = episode <- SerieSeasonEpisodes.get_serie_season_episode!(id) do
      stream_video_chunks(conn, episode)
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

  @video_dir "priv/series"
  defp stream_video_chunks(
         conn,
         %SerieSeasonEpisode{
           video_url: "file://" <> dir
         } = episode
       ) do
    episode = Repo.preload(episode, :season)
    path = Path.join(@video_dir, "#{dir}/#{episode.season.number}/#{episode.number}.mp4")

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
            |> put_resp_header("content-type", "video/mp4")
            |> put_resp_header("content-length", Integer.to_string(length))
            |> put_resp_header("content-range", "bytes #{start}-#{end_pos}/#{file_size}")
            |> send_chunked(:partial_content)
            |> stream_range(path, start, length)

          _ ->
            # Responde com o vídeo completo se não houver "Range"
            conn
            |> put_resp_header("content-type", "video/mp4")
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
         %SerieSeasonEpisode{
           video_url: "https://" <> _
         } = episode
       ) do
    conn =
      conn
      |> put_resp_content_type(episode.mime_type)
      |> send_chunked(:ok)

    HTTPoison.get!(episode.video_url, [], stream_to: self())

    receive do
      %HTTPoison.AsyncChunk{chunk: chunk} ->
        # Envia o chunk ao cliente
        case chunk(conn, chunk) do
          {:ok, conn} -> stream_video_chunks(conn, episode)
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
        stream_video_chunks(conn, episode)
    after
      # Timeout de 5 segundos
      5_000 -> :ok
    end
  end

  def create(conn, %{"serie_season_episode" => serie_season_episode_params}) do
    with {:ok, %SerieSeasonEpisode{} = serie_season_episode} <-
           SerieSeasonEpisodes.create_serie_season_episode(serie_season_episode_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", ~p"/api/serie_season_episodes/#{serie_season_episode}")
      |> render(:show, serie_season_episode: serie_season_episode)
    end
  end

  def show(conn, %{"id" => id}) do
    serie_season_episode = SerieSeasonEpisodes.get_serie_season_episode!(id)
    render(conn, :show, serie_season_episode: serie_season_episode)
  end

  def update(conn, %{"id" => id, "serie_season_episode" => serie_season_episode_params}) do
    serie_season_episode = SerieSeasonEpisodes.get_serie_season_episode!(id)

    with {:ok, %SerieSeasonEpisode{} = serie_season_episode} <-
           SerieSeasonEpisodes.update_serie_season_episode(
             serie_season_episode,
             serie_season_episode_params
           ) do
      render(conn, :show, serie_season_episode: serie_season_episode)
    end
  end

  def delete(conn, %{"id" => id}) do
    serie_season_episode = SerieSeasonEpisodes.get_serie_season_episode!(id)

    with {:ok, %SerieSeasonEpisode{}} <-
           SerieSeasonEpisodes.delete_serie_season_episode(serie_season_episode) do
      send_resp(conn, :no_content, "")
    end
  end
end
