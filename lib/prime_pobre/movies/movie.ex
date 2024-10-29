defmodule PrimePobre.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset
  @sources ~w(file remote)

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "movies" do
    field :description, :string
    field :title, :string
    field :media, :string
    field :source, :string
    field :thumbnail_url, :string
    field :mime_type, :string
    field :genre, :string
    field :duration, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [
      :title,
      :description,
      :media,
      :source,
      :thumbnail_url,
      :mime_type,
      :genre,
      :duration
    ])
    |> validate_required([
      :title,
      :description,
      :media,
      :source,
      :thumbnail_url,
      :mime_type,
      :genre,
      :duration
    ])
    |> validate_inclusion(:source, @sources)
  end
end
