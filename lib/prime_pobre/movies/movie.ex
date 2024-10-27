defmodule PrimePobre.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "movies" do
    field :description, :string
    field :title, :string
    field :video_url, :string
    field :images, {:array, :string}
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
      :video_url,
      :images,
      :mime_type,
      :genre,
      :duration
    ])
    |> validate_required([
      :title,
      :description,
      :video_url,
      :images,
      :mime_type,
      :genre,
      :duration
    ])
  end
end
