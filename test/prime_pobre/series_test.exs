defmodule PrimePobre.SeriesTest do
  use PrimePobre.DataCase

  alias PrimePobre.Series

  describe "series" do
    alias PrimePobre.Series.Serie

    import PrimePobre.SeriesFixtures

    @invalid_attrs %{description: nil, title: nil, images: nil, media: nil}

    test "list_series/0 returns all series" do
      serie = serie_fixture()
      assert Series.list_series() == [serie]
    end

    test "get_serie!/1 returns the serie with given id" do
      serie = serie_fixture()
      assert Series.get_serie!(serie.id) == serie
    end

    test "create_serie/1 with valid data creates a serie" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        images: "some images",
        media: "some media"
      }

      assert {:ok, %Serie{} = serie} = Series.create_serie(valid_attrs)
      assert serie.description == "some description"
      assert serie.title == "some title"
      assert serie.images == "some images"
      assert serie.media == "some media"
    end

    test "create_serie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Series.create_serie(@invalid_attrs)
    end

    test "update_serie/2 with valid data updates the serie" do
      serie = serie_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        images: "some updated images",
        media: "some updated media"
      }

      assert {:ok, %Serie{} = serie} = Series.update_serie(serie, update_attrs)
      assert serie.description == "some updated description"
      assert serie.title == "some updated title"
      assert serie.images == "some updated images"
      assert serie.media == "some updated media"
    end

    test "update_serie/2 with invalid data returns error changeset" do
      serie = serie_fixture()
      assert {:error, %Ecto.Changeset{}} = Series.update_serie(serie, @invalid_attrs)
      assert serie == Series.get_serie!(serie.id)
    end

    test "delete_serie/1 deletes the serie" do
      serie = serie_fixture()
      assert {:ok, %Serie{}} = Series.delete_serie(serie)
      assert_raise Ecto.NoResultsError, fn -> Series.get_serie!(serie.id) end
    end

    test "change_serie/1 returns a serie changeset" do
      serie = serie_fixture()
      assert %Ecto.Changeset{} = Series.change_serie(serie)
    end
  end
end
