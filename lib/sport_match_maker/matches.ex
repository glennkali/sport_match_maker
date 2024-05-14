defmodule SportMatchMaker.Matches do
  @moduledoc """
  The Games context.
  """
  import Ecto.Query, warn: false
  alias SportMatchMaker.{Repo, Scope}
  alias SportMatchMaker.Matches.{Match, UserMatch}

  @doc """
  Creates a match for the current scope user.

  """
  def create_match(%Scope{} = scope, user) do
    match = %Match{} |> Match.changeset(%{title: "User-#{scope.current_user.id} <> User-#{user.id}"})

    Ecto.Multi.new()
    |> Ecto.Multi.insert(:match, match)
    |> Ecto.Multi.merge(fn %{match: match} ->
      Ecto.Multi.new()
      |> Ecto.Multi.insert_all(
        :insert_all,
        UserMatch,
        [
          %{match_id: match.id, user_id: scope.current_user.id},
          %{match_id: match.id, user_id: user.id}
        ]
      )
    end)
    |> Repo.transaction()
    |> case do
      {:ok, results} ->
        IO.puts "Result contains #{inspect results}"
        {:ok, results.match}

      {:error, :match, failed_val, _changes_so_far} ->
        {:error, failed_val}
    end
  end
end
