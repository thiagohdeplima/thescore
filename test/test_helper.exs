ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(TheScore.Repo, :manual)

{:ok, _} = Application.ensure_all_started(:faker)
{:ok, _} = Application.ensure_all_started(:ex_machina)
