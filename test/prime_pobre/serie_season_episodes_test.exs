defmodule PrimePobre.SerieSeasonEpisodesTest do
  use PrimePobre.DataCase

  alias PrimePobre.SerieSeasonEpisodes

  describe "serie_season_episodes" do
    alias PrimePobre.SerieSeasonEpisodes.SerieSeasonEpisode

    import PrimePobre.SerieSeasonEpisodesFixtures

    @invalid_attrs %{description: nil, title: nil, media: nil, images: nil}

    test "list_serie_season_episodes/0 returns all serie_season_episodes" do
      serie_season_episode = serie_season_episode_fixture()
      assert SerieSeasonEpisodes.list_serie_season_episodes() == [serie_season_episode]
    end

    test "get_serie_season_episode!/1 returns the serie_season_episode with given id" do
      serie_season_episode = serie_season_episode_fixture()

      assert SerieSeasonEpisodes.get_serie_season_episode!(serie_season_episode.id) ==
               serie_season_episode
    end

    test "create_serie_season_episode/1 with valid data creates a serie_season_episode" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        media: "some media",
        images: "some images"
      }

      assert {:ok, %SerieSeasonEpisode{} = serie_season_episode} =
               SerieSeasonEpisodes.create_serie_season_episode(valid_attrs)

      assert serie_season_episode.description == "some description"
      assert serie_season_episode.title == "some title"
      assert serie_season_episode.media == "some media"
      assert serie_season_episode.images == "some images"
    end

    test "create_serie_season_episode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               SerieSeasonEpisodes.create_serie_season_episode(@invalid_attrs)
    end

    test "update_serie_season_episode/2 with valid data updates the serie_season_episode" do
      serie_season_episode = serie_season_episode_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        media: "some updated media",
        images: "some updated images"
      }

      assert {:ok, %SerieSeasonEpisode{} = serie_season_episode} =
               SerieSeasonEpisodes.update_serie_season_episode(serie_season_episode, update_attrs)

      assert serie_season_episode.description == "some updated description"
      assert serie_season_episode.title == "some updated title"
      assert serie_season_episode.media == "some updated media"
      assert serie_season_episode.images == "some updated images"
    end

    test "update_serie_season_episode/2 with invalid data returns error changeset" do
      serie_season_episode = serie_season_episode_fixture()

      assert {:error, %Ecto.Changeset{}} =
               SerieSeasonEpisodes.update_serie_season_episode(
                 serie_season_episode,
                 @invalid_attrs
               )

      assert serie_season_episode ==
               SerieSeasonEpisodes.get_serie_season_episode!(serie_season_episode.id)
    end

    test "delete_serie_season_episode/1 deletes the serie_season_episode" do
      serie_season_episode = serie_season_episode_fixture()

      assert {:ok, %SerieSeasonEpisode{}} =
               SerieSeasonEpisodes.delete_serie_season_episode(serie_season_episode)

      assert_raise Ecto.NoResultsError, fn ->
        SerieSeasonEpisodes.get_serie_season_episode!(serie_season_episode.id)
      end
    end

    test "change_serie_season_episode/1 returns a serie_season_episode changeset" do
      serie_season_episode = serie_season_episode_fixture()

      assert %Ecto.Changeset{} =
               SerieSeasonEpisodes.change_serie_season_episode(serie_season_episode)
    end
  end
end
