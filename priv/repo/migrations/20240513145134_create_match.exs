defmodule SportMatchMaker.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :title, :string

      timestamps()
    end

    create table(:users_matches, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      add :match_id, references(:matches, on_delete: :delete_all), primary_key: true
      timestamps(default: fragment("NOW()"))
    end

    create index(:users_matches, [:user_id])
    create index(:users_matches, [:match_id])
  end
end
