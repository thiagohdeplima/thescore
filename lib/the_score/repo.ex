defmodule TheScore.Repo do
  use Ecto.Repo,
    otp_app: :the_score,
    adapter: Ecto.Adapters.Postgres

  use Scrivener,
    page_size: 20
end
