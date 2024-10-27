defmodule PrimePobre.SerieSeasons do
  @moduledoc """
  The SerieSeasons context.
  """

  import Ecto.Query, warn: false
  alias PrimePobre.Repo

  alias PrimePobre.SerieSeasons.SerieSeason
  alias PrimePobre.Series.Serie

  @doc """
  Returns the list of serie_seasons.

  ## Examples

      iex> list_serie_seasons()
      [%SerieSeason{}, ...]

  """
  def list_serie_seasons do
    Repo.all(from ss in SerieSeason, order_by: [asc: ss.number])
  end

  @doc """
  Gets a single serie_season.

  Raises `Ecto.NoResultsError` if the Serie season does not exist.

  ## Examples

      iex> get_serie_season!(123)
      %SerieSeason{}

      iex> get_serie_season!(456)
      ** (Ecto.NoResultsError)

  """
  def get_serie_season!(id), do: Repo.get!(SerieSeason, id)

  @doc """
  Creates a serie_season.

  ## Examples

      iex> create_serie_season(%{field: value})
      {:ok, %SerieSeason{}}

      iex> create_serie_season(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_serie_season(%Serie{} = serie, attrs \\ %{}) do
    %SerieSeason{}
    |> SerieSeason.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:serie, serie)
    |> Repo.insert()
  end

  @doc """
  Updates a serie_season.

  ## Examples

      iex> update_serie_season(serie_season, %{field: new_value})
      {:ok, %SerieSeason{}}

      iex> update_serie_season(serie_season, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_serie_season(%SerieSeason{} = serie_season, attrs) do
    serie_season
    |> SerieSeason.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a serie_season.

  ## Examples

      iex> delete_serie_season(serie_season)
      {:ok, %SerieSeason{}}

      iex> delete_serie_season(serie_season)
      {:error, %Ecto.Changeset{}}

  """
  def delete_serie_season(%SerieSeason{} = serie_season) do
    Repo.delete(serie_season)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking serie_season changes.

  ## Examples

      iex> change_serie_season(serie_season)
      %Ecto.Changeset{data: %SerieSeason{}}

  """
  def change_serie_season(%SerieSeason{} = serie_season, attrs \\ %{}) do
    SerieSeason.changeset(serie_season, attrs)
  end
end
