defmodule PrimePobre.Repo.Migrations.CreateSerieSeasons do
  use Ecto.Migration

  def change do
    create table(:serie_seasons, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :serie_id, references(:series, on_delete: :delete_all, type: :binary_id)
      add :number, :integer

      timestamps(type: :utc_datetime)
    end

    create unique_index(:serie_seasons, [:serie_id, :number])
  end
end
