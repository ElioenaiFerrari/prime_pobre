defmodule PrimePobreWeb.SerieControllerTest do
  use PrimePobreWeb.ConnCase

  import PrimePobre.SeriesFixtures

  alias PrimePobre.Series.Serie

  @create_attrs %{
    description: "some description",
    title: "some title",
    images: "some images",
    media: "some media"
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    images: "some updated images",
    media: "some updated media"
  }
  @invalid_attrs %{description: nil, title: nil, images: nil, media: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all series", %{conn: conn} do
      conn = get(conn, ~p"/api/series")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create serie" do
    test "renders serie when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/series", serie: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/series/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "images" => "some images",
               "title" => "some title",
               "media" => "some media"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/series", serie: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update serie" do
    setup [:create_serie]

    test "renders serie when data is valid", %{conn: conn, serie: %Serie{id: id} = serie} do
      conn = put(conn, ~p"/api/series/#{serie}", serie: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/series/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "images" => "some updated images",
               "title" => "some updated title",
               "media" => "some updated media"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, serie: serie} do
      conn = put(conn, ~p"/api/series/#{serie}", serie: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete serie" do
    setup [:create_serie]

    test "deletes chosen serie", %{conn: conn, serie: serie} do
      conn = delete(conn, ~p"/api/series/#{serie}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/series/#{serie}")
      end
    end
  end

  defp create_serie(_) do
    serie = serie_fixture()
    %{serie: serie}
  end
end
