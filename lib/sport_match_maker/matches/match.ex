defmodule SportMatchMaker.Matches.Match do
  use Ecto.Schema
  import Ecto.Changeset

  alias SportMatchMaker.Matches.{Game, UserMatch}
  alias SportMatchMaker.Accounts.User

  schema "matches" do
    field :title, :string

    has_many :games, Game
    many_to_many :user, User, join_through: UserMatch, on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
