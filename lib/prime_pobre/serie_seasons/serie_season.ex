defmodule PrimePobre.SerieSeasons.SerieSeason do
  use Ecto.Schema
  import Ecto.Changeset
  alias PrimePobre.Series.Serie
  alias PrimePobre.SerieSeasonEpisodes.SerieSeasonEpisode

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "serie_seasons" do
    field :number, :integer
    belongs_to :serie, Serie
    has_many :episodes, SerieSeasonEpisode, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(serie_season, attrs) do
    serie_season
    |> cast(attrs, [:number])
    |> validate_required([:number])
  end
end
