defmodule PrimePobre.SerieSeasonEpisodes.SerieSeasonEpisode do
  use Ecto.Schema
  import Ecto.Changeset
  alias PrimePobre.SerieSeasons.SerieSeason

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "serie_season_episodes" do
    field :description, :string
    field :title, :string
    field :video_url, :string
    field :images, {:array, :string}
    field :mime_type, :string
    belongs_to :season, SerieSeason

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(serie_season_episode, attrs) do
    serie_season_episode
    |> cast(attrs, [:title, :description, :video_url, :images, :mime_type])
    |> validate_required([:title, :description, :video_url, :images, :mime_type])
  end
end
