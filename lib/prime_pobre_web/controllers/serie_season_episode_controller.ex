defmodule PrimePobreWeb.SerieSeasonEpisodeController do
  use PrimePobreWeb, :controller

  alias PrimePobre.SerieSeasonEpisodes
  alias PrimePobre.SerieSeasonEpisodes.SerieSeasonEpisode

  action_fallback PrimePobreWeb.FallbackController

  def index(conn, _params) do
    serie_season_episodes = SerieSeasonEpisodes.list_serie_season_episodes()
    render(conn, :index, serie_season_episodes: serie_season_episodes)
  end

  def create(conn, %{"serie_season_episode" => serie_season_episode_params}) do
    with {:ok, %SerieSeasonEpisode{} = serie_season_episode} <- SerieSeasonEpisodes.create_serie_season_episode(serie_season_episode_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/serie_season_episodes/#{serie_season_episode}")
      |> render(:show, serie_season_episode: serie_season_episode)
    end
  end

  def show(conn, %{"id" => id}) do
    serie_season_episode = SerieSeasonEpisodes.get_serie_season_episode!(id)
    render(conn, :show, serie_season_episode: serie_season_episode)
  end

  def update(conn, %{"id" => id, "serie_season_episode" => serie_season_episode_params}) do
    serie_season_episode = SerieSeasonEpisodes.get_serie_season_episode!(id)

    with {:ok, %SerieSeasonEpisode{} = serie_season_episode} <- SerieSeasonEpisodes.update_serie_season_episode(serie_season_episode, serie_season_episode_params) do
      render(conn, :show, serie_season_episode: serie_season_episode)
    end
  end

  def delete(conn, %{"id" => id}) do
    serie_season_episode = SerieSeasonEpisodes.get_serie_season_episode!(id)

    with {:ok, %SerieSeasonEpisode{}} <- SerieSeasonEpisodes.delete_serie_season_episode(serie_season_episode) do
      send_resp(conn, :no_content, "")
    end
  end
end
