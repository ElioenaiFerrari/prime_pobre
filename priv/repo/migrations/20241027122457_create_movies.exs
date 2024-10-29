defmodule PrimePobre.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :string
      add :media, :string
      add :source, :string
      add :thumbnail_url, :string
      add :mime_type, :string
      add :genre, :string
      add :duration, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
