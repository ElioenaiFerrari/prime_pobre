defmodule PrimePobre.SerieSeasonEpisodes.SerieSeasonEpisode do
  use Ecto.Schema
  import Ecto.Changeset
  alias PrimePobre.SerieSeasons.SerieSeason
  @sources ~w(file remote)

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "serie_season_episodes" do
    field :description, :string
    field :title, :string
    field :media, :string
    field :source, :string
    field :images, {:array, :string}
    field :mime_type, :string
    field :duration, :integer
    field :number, :integer
    belongs_to :season, SerieSeason

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(serie_season_episode, attrs) do
    serie_season_episode
    |> cast(attrs, [
      :title,
      :description,
      :media,
      :source,
      :images,
      :mime_type,
      :duration,
      :number
    ])
    |> validate_required([
      :title,
      :description,
      :media,
      :source,
      :images,
      :mime_type,
      :duration,
      :number
    ])
    |> validate_inclusion(:source, @sources)
  end
end
