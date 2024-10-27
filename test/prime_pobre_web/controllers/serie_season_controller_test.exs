defmodule PrimePobreWeb.SerieSeasonControllerTest do
  use PrimePobreWeb.ConnCase

  import PrimePobre.SerieSeasonsFixtures

  alias PrimePobre.SerieSeasons.SerieSeason

  @create_attrs %{
    number: "some number"
  }
  @update_attrs %{
    number: "some updated number"
  }
  @invalid_attrs %{number: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all serie_seasons", %{conn: conn} do
      conn = get(conn, ~p"/api/serie_seasons")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create serie_season" do
    test "renders serie_season when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/serie_seasons", serie_season: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/serie_seasons/#{id}")

      assert %{
               "id" => ^id,
               "number" => "some number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/serie_seasons", serie_season: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update serie_season" do
    setup [:create_serie_season]

    test "renders serie_season when data is valid", %{conn: conn, serie_season: %SerieSeason{id: id} = serie_season} do
      conn = put(conn, ~p"/api/serie_seasons/#{serie_season}", serie_season: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/serie_seasons/#{id}")

      assert %{
               "id" => ^id,
               "number" => "some updated number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, serie_season: serie_season} do
      conn = put(conn, ~p"/api/serie_seasons/#{serie_season}", serie_season: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete serie_season" do
    setup [:create_serie_season]

    test "deletes chosen serie_season", %{conn: conn, serie_season: serie_season} do
      conn = delete(conn, ~p"/api/serie_seasons/#{serie_season}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/serie_seasons/#{serie_season}")
      end
    end
  end

  defp create_serie_season(_) do
    serie_season = serie_season_fixture()
    %{serie_season: serie_season}
  end
end
