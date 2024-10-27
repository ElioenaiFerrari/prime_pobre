defmodule PrimePobre.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :string
      add :file_url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
