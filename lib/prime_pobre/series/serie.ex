defmodule PrimePobre.Series.Serie do
  use Ecto.Schema
  import Ecto.Changeset
  alias PrimePobre.SerieSeasons.SerieSeason

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "series" do
    field :description, :string
    field :title, :string
    field :images, {:array, :string}
    field :video_url, :string
    has_many :serie_seasons, SerieSeason, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(serie, attrs) do
    serie
    |> cast(attrs, [:title, :description, :images, :video_url])
    |> validate_required([:title, :description, :images, :video_url])
  end
end