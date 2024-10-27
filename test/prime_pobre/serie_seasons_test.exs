defmodule PrimePobre.SerieSeasonsTest do
  use PrimePobre.DataCase

  alias PrimePobre.SerieSeasons

  describe "serie_seasons" do
    alias PrimePobre.SerieSeasons.SerieSeason

    import PrimePobre.SerieSeasonsFixtures

    @invalid_attrs %{number: nil}

    test "list_serie_seasons/0 returns all serie_seasons" do
      serie_season = serie_season_fixture()
      assert SerieSeasons.list_serie_seasons() == [serie_season]
    end

    test "get_serie_season!/1 returns the serie_season with given id" do
      serie_season = serie_season_fixture()
      assert SerieSeasons.get_serie_season!(serie_season.id) == serie_season
    end

    test "create_serie_season/1 with valid data creates a serie_season" do
      valid_attrs = %{number: "some number"}

      assert {:ok, %SerieSeason{} = serie_season} = SerieSeasons.create_serie_season(valid_attrs)
      assert serie_season.number == "some number"
    end

    test "create_serie_season/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SerieSeasons.create_serie_season(@invalid_attrs)
    end

    test "update_serie_season/2 with valid data updates the serie_season" do
      serie_season = serie_season_fixture()
      update_attrs = %{number: "some updated number"}

      assert {:ok, %SerieSeason{} = serie_season} = SerieSeasons.update_serie_season(serie_season, update_attrs)
      assert serie_season.number == "some updated number"
    end

    test "update_serie_season/2 with invalid data returns error changeset" do
      serie_season = serie_season_fixture()
      assert {:error, %Ecto.Changeset{}} = SerieSeasons.update_serie_season(serie_season, @invalid_attrs)
      assert serie_season == SerieSeasons.get_serie_season!(serie_season.id)
    end

    test "delete_serie_season/1 deletes the serie_season" do
      serie_season = serie_season_fixture()
      assert {:ok, %SerieSeason{}} = SerieSeasons.delete_serie_season(serie_season)
      assert_raise Ecto.NoResultsError, fn -> SerieSeasons.get_serie_season!(serie_season.id) end
    end

    test "change_serie_season/1 returns a serie_season changeset" do
      serie_season = serie_season_fixture()
      assert %Ecto.Changeset{} = SerieSeasons.change_serie_season(serie_season)
    end
  end
end
