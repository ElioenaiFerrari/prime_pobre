defmodule PrimePobre.MoviesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PrimePobre.Movies` context.
  """

  @doc """
  Generate a movie.
  """
  def movie_fixture(attrs \\ %{}) do
    {:ok, movie} =
      attrs
      |> Enum.into(%{
        description: "some description",
        media: "some media",
        title: "some title"
      })
      |> PrimePobre.Movies.create_movie()

    movie
  end
end
