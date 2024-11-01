defmodule PrimePobre.Repo.Migrations.CreateSerieSeasonEpisodes do
  use Ecto.Migration

  def change do
    create table(:serie_season_episodes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :season_id, references(:serie_seasons, on_delete: :delete_all, type: :binary_id)
      add :title, :string
      add :description, :string
      add :media, :string
      add :source, :string
      add :thumbnail_url, :string
      add :mime_type, :string
      add :duration, :integer
      add :number, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
