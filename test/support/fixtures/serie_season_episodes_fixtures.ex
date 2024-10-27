defmodule PrimePobre.SerieSeasonEpisodesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PrimePobre.SerieSeasonEpisodes` context.
  """

  @doc """
  Generate a serie_season_episode.
  """
  def serie_season_episode_fixture(attrs \\ %{}) do
    {:ok, serie_season_episode} =
      attrs
      |> Enum.into(%{
        description: "some description",
        images: "some images",
        title: "some title",
        video_url: "some video_url"
      })
      |> PrimePobre.SerieSeasonEpisodes.create_serie_season_episode()

    serie_season_episode
  end
end
