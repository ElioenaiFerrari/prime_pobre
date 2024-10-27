defmodule PrimePobreWeb.SerieSeasonJSON do
  alias PrimePobre.SerieSeasons.SerieSeason

  @doc """
  Renders a list of serie_seasons.
  """
  def index(%{serie_seasons: serie_seasons}) do
    %{data: for(serie_season <- serie_seasons, do: data(serie_season))}
  end

  @doc """
  Renders a single serie_season.
  """
  def show(%{serie_season: serie_season}) do
    %{data: data(serie_season)}
  end

  defp data(%SerieSeason{} = serie_season) do
    %{
      id: serie_season.id,
      number: serie_season.number
    }
  end
end
