defmodule PrimePobre.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "movies" do
    field :description, :string
    field :title, :string
    field :file_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :description, :file_url])
    |> validate_required([:title, :description, :file_url])
  end
end
