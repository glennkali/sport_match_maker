defmodule SportMatchMaker.Matches.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias SportMatchMaker.Matches.Match

  schema "games" do
    field :status, Ecto.Enum, values: [:started, :completed], default: :started
    field :title, :string
    field :scheduled_at, :utc_datetime

    belongs_to :match, Match

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:title, :status, :scheduled_at])
    |> validate_required([:title, :scheduled_at])
  end
end
