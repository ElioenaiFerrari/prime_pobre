defmodule PrimePobre.Series.Serie do
  use Ecto.Schema
  import Ecto.Changeset
  alias PrimePobre.SerieSeasons.SerieSeason

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "series" do
    field :description, :string
    field :title, :string
    field :genre, :string
    field :thumbnail_url, :string
    has_many :seasons, SerieSeason, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(serie, attrs) do
    serie
    |> cast(attrs, [:title, :description, :genre, :thumbnail_url])
    |> validate_required([:title, :description, :genre, :thumbnail_url])
  end
end
