defmodule PrimePobreWeb.SerieSeasonEpisodeControllerTest do
  use PrimePobreWeb.ConnCase

  import PrimePobre.SerieSeasonEpisodesFixtures

  alias PrimePobre.SerieSeasonEpisodes.SerieSeasonEpisode

  @create_attrs %{
    description: "some description",
    title: "some title",
    video_url: "some video_url",
    images: "some images"
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    video_url: "some updated video_url",
    images: "some updated images"
  }
  @invalid_attrs %{description: nil, title: nil, video_url: nil, images: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all serie_season_episodes", %{conn: conn} do
      conn = get(conn, ~p"/api/serie_season_episodes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create serie_season_episode" do
    test "renders serie_season_episode when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/serie_season_episodes", serie_season_episode: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/serie_season_episodes/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "images" => "some images",
               "title" => "some title",
               "video_url" => "some video_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/serie_season_episodes", serie_season_episode: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update serie_season_episode" do
    setup [:create_serie_season_episode]

    test "renders serie_season_episode when data is valid", %{conn: conn, serie_season_episode: %SerieSeasonEpisode{id: id} = serie_season_episode} do
      conn = put(conn, ~p"/api/serie_season_episodes/#{serie_season_episode}", serie_season_episode: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/serie_season_episodes/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "images" => "some updated images",
               "title" => "some updated title",
               "video_url" => "some updated video_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, serie_season_episode: serie_season_episode} do
      conn = put(conn, ~p"/api/serie_season_episodes/#{serie_season_episode}", serie_season_episode: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete serie_season_episode" do
    setup [:create_serie_season_episode]

    test "deletes chosen serie_season_episode", %{conn: conn, serie_season_episode: serie_season_episode} do
      conn = delete(conn, ~p"/api/serie_season_episodes/#{serie_season_episode}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/serie_season_episodes/#{serie_season_episode}")
      end
    end
  end

  defp create_serie_season_episode(_) do
    serie_season_episode = serie_season_episode_fixture()
    %{serie_season_episode: serie_season_episode}
  end
end
