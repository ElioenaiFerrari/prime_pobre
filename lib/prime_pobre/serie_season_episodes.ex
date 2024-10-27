defmodule PrimePobre.SerieSeasonEpisodes do
  @moduledoc """
  The SerieSeasonEpisodes context.
  """

  import Ecto.Query, warn: false
  alias PrimePobre.Repo

  alias PrimePobre.SerieSeasonEpisodes.SerieSeasonEpisode
  alias PrimePobre.SerieSeasons.SerieSeason

  @doc """
  Returns the list of serie_season_episodes.

  ## Examples

      iex> list_serie_season_episodes()
      [%SerieSeasonEpisode{}, ...]

  """
  def list_serie_season_episodes do
    Repo.all(from s in SerieSeasonEpisode, order_by: [asc: s.number])
  end

  @doc """
  Gets a single serie_season_episode.

  Raises `Ecto.NoResultsError` if the Serie season episode does not exist.

  ## Examples

      iex> get_serie_season_episode!(123)
      %SerieSeasonEpisode{}

      iex> get_serie_season_episode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_serie_season_episode!(id), do: Repo.get!(SerieSeasonEpisode, id)

  @doc """
  Creates a serie_season_episode.

  ## Examples

      iex> create_serie_season_episode(%{field: value})
      {:ok, %SerieSeasonEpisode{}}

      iex> create_serie_season_episode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_serie_season_episode(%SerieSeason{} = season, attrs \\ %{}) do
    %SerieSeasonEpisode{}
    |> SerieSeasonEpisode.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:season, season)
    |> Repo.insert()
  end

  @doc """
  Updates a serie_season_episode.

  ## Examples

      iex> update_serie_season_episode(serie_season_episode, %{field: new_value})
      {:ok, %SerieSeasonEpisode{}}

      iex> update_serie_season_episode(serie_season_episode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_serie_season_episode(%SerieSeasonEpisode{} = serie_season_episode, attrs) do
    serie_season_episode
    |> SerieSeasonEpisode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a serie_season_episode.

  ## Examples

      iex> delete_serie_season_episode(serie_season_episode)
      {:ok, %SerieSeasonEpisode{}}

      iex> delete_serie_season_episode(serie_season_episode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_serie_season_episode(%SerieSeasonEpisode{} = serie_season_episode) do
    Repo.delete(serie_season_episode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking serie_season_episode changes.

  ## Examples

      iex> change_serie_season_episode(serie_season_episode)
      %Ecto.Changeset{data: %SerieSeasonEpisode{}}

  """
  def change_serie_season_episode(%SerieSeasonEpisode{} = serie_season_episode, attrs \\ %{}) do
    SerieSeasonEpisode.changeset(serie_season_episode, attrs)
  end
end
