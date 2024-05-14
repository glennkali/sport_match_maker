defmodule SportMatchMaker.Matches.UserMatch do
  use Ecto.Schema
  import Ecto.Changeset

  alias SportMatchMaker.Accounts.User
  alias SportMatchMaker.Matches.Match

  @already_exists "ALREADY_EXISTS"

  @primary_key false
  schema "users_matches" do
    belongs_to :user, User, primary_key: true
    belongs_to :match, Match, primary_key: true
    timestamps(type: :utc_datetime)
  end

  def changeset(users_matches, params \\ %{}) do
    users_matches
    |> cast(params, [:user_id, :match_id])
    |> validate_required([:user_id, :match_id])
    |> foreign_key_constraint(:match_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint([:user, :match],
      name: :user_id_match_id_unique_index,
      message: @already_exists
    )
  end
end
