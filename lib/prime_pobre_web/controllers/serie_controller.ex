defmodule PrimePobreWeb.SerieController do
  use PrimePobreWeb, :controller

  alias PrimePobre.Series
  alias PrimePobre.Series.Serie

  action_fallback PrimePobreWeb.FallbackController

  def index(conn, _params) do
    series = Series.list_series()
    render(conn, :index, series: series)
  end

  def create(conn, %{"serie" => serie_params}) do
    with {:ok, %Serie{} = serie} <- Series.create_serie(serie_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/series/#{serie}")
      |> render(:show, serie: serie)
    end
  end

  def show(conn, %{"id" => id}) do
    serie = Series.get_serie!(id)
    render(conn, :show, serie: serie)
  end

  def update(conn, %{"id" => id, "serie" => serie_params}) do
    serie = Series.get_serie!(id)

    with {:ok, %Serie{} = serie} <- Series.update_serie(serie, serie_params) do
      render(conn, :show, serie: serie)
    end
  end

  def delete(conn, %{"id" => id}) do
    serie = Series.get_serie!(id)

    with {:ok, %Serie{}} <- Series.delete_serie(serie) do
      send_resp(conn, :no_content, "")
    end
  end
end
