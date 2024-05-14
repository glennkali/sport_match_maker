defmodule SportMatchMaker.Repo.Migrations.AddUserProfile do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :age_group, :string, size: 40
      add :gender, :string
      add :borough, :string
      add :skill_level, :string
      add :game_style_preference, :string
      add :game_format_preference, :string
      add :game_time_preference, :utc_datetime
      add :game_recurrence, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
