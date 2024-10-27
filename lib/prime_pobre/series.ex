defmodule PrimePobre.Series do
  @moduledoc """
  The Series context.
  """

  import Ecto.Query, warn: false
  alias PrimePobre.Repo

  alias PrimePobre.Series.Serie

  @doc """
  Returns the list of series.

  ## Examples

      iex> list_series()
      [%Serie{}, ...]

  """
  def list_series do
    Repo.all(Serie)
  end

  @doc """
  Gets a single serie.

  Raises `Ecto.NoResultsError` if the Serie does not exist.

  ## Examples

      iex> get_serie!(123)
      %Serie{}

      iex> get_serie!(456)
      ** (Ecto.NoResultsError)

  """
  def get_serie!(id), do: Repo.get!(Serie, id)

  @doc """
  Creates a serie.

  ## Examples

      iex> create_serie(%{field: value})
      {:ok, %Serie{}}

      iex> create_serie(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_serie(attrs \\ %{}) do
    %Serie{}
    |> Serie.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a serie.

  ## Examples

      iex> update_serie(serie, %{field: new_value})
      {:ok, %Serie{}}

      iex> update_serie(serie, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_serie(%Serie{} = serie, attrs) do
    serie
    |> Serie.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a serie.

  ## Examples

      iex> delete_serie(serie)
      {:ok, %Serie{}}

      iex> delete_serie(serie)
      {:error, %Ecto.Changeset{}}

  """
  def delete_serie(%Serie{} = serie) do
    Repo.delete(serie)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking serie changes.

  ## Examples

      iex> change_serie(serie)
      %Ecto.Changeset{data: %Serie{}}

  """
  def change_serie(%Serie{} = serie, attrs \\ %{}) do
    Serie.changeset(serie, attrs)
  end
end
