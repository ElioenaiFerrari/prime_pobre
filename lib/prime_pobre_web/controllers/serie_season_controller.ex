defmodule PrimePobreWeb.SerieSeasonController do
  use PrimePobreWeb, :controller

  alias PrimePobre.SerieSeasons
  alias PrimePobre.SerieSeasons.SerieSeason

  action_fallback PrimePobreWeb.FallbackController

  def index(conn, _params) do
    serie_seasons = SerieSeasons.list_serie_seasons()
    render(conn, :index, serie_seasons: serie_seasons)
  end

  def create(conn, %{"serie_season" => serie_season_params}) do
    with {:ok, %SerieSeason{} = serie_season} <-
           SerieSeasons.create_serie_season(serie_season_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/serie_seasons/#{serie_season}")
      |> render(:show, serie_season: serie_season)
    end
  end

  def show(conn, %{"id" => id}) do
    serie_season = SerieSeasons.get_serie_season!(id)
    render(conn, :show, serie_season: serie_season)
  end

  def update(conn, %{"id" => id, "serie_season" => serie_season_params}) do
    serie_season = SerieSeasons.get_serie_season!(id)

    with {:ok, %SerieSeason{} = serie_season} <-
           SerieSeasons.update_serie_season(serie_season, serie_season_params) do
      render(conn, :show, serie_season: serie_season)
    end
  end

  def delete(conn, %{"id" => id}) do
    serie_season = SerieSeasons.get_serie_season!(id)

    with {:ok, %SerieSeason{}} <- SerieSeasons.delete_serie_season(serie_season) do
      send_resp(conn, :no_content, "")
    end
  end
end
