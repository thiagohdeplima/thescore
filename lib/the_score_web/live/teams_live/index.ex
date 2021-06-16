defmodule TheScoreWeb.TeamsLive.Index do
  @moduledoc false

  use TheScoreWeb, :live_view

  alias TheScore.Statistics

  @impl true
  def mount(_params, _session, socket) do
    teams = Statistics.get_total_yds_by_team()

    {:ok, assign(socket, :teams, teams)}
  end
end