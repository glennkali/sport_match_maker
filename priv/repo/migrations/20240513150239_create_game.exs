defmodule SportMatchMaker.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :status, :string, null: false
      add :title, :string
      add :scheduled_at, :utc_datetime
      add :match_id, references(:matches, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
