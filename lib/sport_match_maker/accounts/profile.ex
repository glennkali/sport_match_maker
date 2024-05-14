defmodule SportMatchMaker.Accounts.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  alias SportMatchMaker.Accounts.User

  schema "profiles" do
    field :age_group, :string
    field :gender, Ecto.Enum, values: [:male, :female]
    field :borough, :string
    field :skill_level, Ecto.Enum, values: [:beginner, :intermediate, :advanced, :competitor]
    field :game_style_preference, Ecto.Enum, values: [:practice, :competition, :all]
    field :game_format_preference, Ecto.Enum, values: [:single, :double, :all]
    field :game_time_preference, :utc_datetime
    field :game_recurrence, Ecto.Enum, values: [:daily, :weekly, :never], default: :never

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:age_group, :gender, :skill_level, :borough, :game_style_preference, :game_format_preference, :game_time_preference, :game_recurrence])
    |> validate_required([:age_group, :gender, :borough, :skill_level, :game_time_preference])
  end
end
