defmodule SportMatchMaker.Repo do
  use Ecto.Repo,
    otp_app: :sport_match_maker,
    adapter: Ecto.Adapters.Postgres
end
