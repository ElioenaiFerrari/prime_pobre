defmodule PrimePobreWeb.SerieJSON do
  alias PrimePobre.Series.Serie

  @doc """
  Renders a list of series.
  """
  def index(%{series: series}) do
    %{data: for(serie <- series, do: data(serie))}
  end

  @doc """
  Renders a single serie.
  """
  def show(%{serie: serie}) do
    %{data: data(serie)}
  end

  defp data(%Serie{} = serie) do
    %{
      id: serie.id,
      title: serie.title,
      description: serie.description,
      images: serie.images,
      video_url: serie.video_url
    }
  end
end
