defmodule TheScoreWeb.PlayerController do
  use TheScoreWeb, :controller

  alias TheScore.Statistics

  action_fallback TheScoreWeb.FallbackController

  defdelegate open_api_operation(action),
    to: TheScore.ApiSpec.Operations.Player

  def index(conn, params) do
    with page = %Scrivener.Page{} <- Statistics.get_players_page(params) do
      render(conn, "index.json", page: page)
    end
  end

  def show(conn, %{"player_id" => player_id}) do
    with {:ok, player} <- Statistics.get_player(player_id) do
      render(conn, "show.json", player: player)
    end
  end
end
