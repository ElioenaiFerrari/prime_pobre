defmodule PrimePobreWeb.SerieSeasonEpisodeJSON do
  alias PrimePobre.SerieSeasonEpisodes.SerieSeasonEpisode

  @doc """
  Renders a list of serie_season_episodes.
  """
  def index(%{serie_season_episodes: serie_season_episodes}) do
    %{data: for(serie_season_episode <- serie_season_episodes, do: data(serie_season_episode))}
  end

  @doc """
  Renders a single serie_season_episode.
  """
  def show(%{serie_season_episode: serie_season_episode}) do
    %{data: data(serie_season_episode)}
  end

  defp data(%SerieSeasonEpisode{} = serie_season_episode) do
    %{
      id: serie_season_episode.id,
      title: serie_season_episode.title,
      description: serie_season_episode.description,
      media: serie_season_episode.media,
      images: serie_season_episode.images,
      duration: serie_season_episode.duration
    }
  end
end
