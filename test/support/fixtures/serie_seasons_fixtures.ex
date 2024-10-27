defmodule PrimePobre.SerieSeasonsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PrimePobre.SerieSeasons` context.
  """

  @doc """
  Generate a serie_season.
  """
  def serie_season_fixture(attrs \\ %{}) do
    {:ok, serie_season} =
      attrs
      |> Enum.into(%{
        number: "some number"
      })
      |> PrimePobre.SerieSeasons.create_serie_season()

    serie_season
  end
end
