defmodule PrimePobre.Repo.Migrations.CreateSeries do
  use Ecto.Migration

  def change do
    create table(:series, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :string
      add :thumbnail_url, :string
      add :genre, :string

      timestamps(type: :utc_datetime)
    end
  end
end
