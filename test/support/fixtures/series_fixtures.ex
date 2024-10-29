defmodule PrimePobre.SeriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PrimePobre.Series` context.
  """

  @doc """
  Generate a serie.
  """
  def serie_fixture(attrs \\ %{}) do
    {:ok, serie} =
      attrs
      |> Enum.into(%{
        description: "some description",
        images: "some images",
        title: "some title",
        media: "some media"
      })
      |> PrimePobre.Series.create_serie()

    serie
  end
end
