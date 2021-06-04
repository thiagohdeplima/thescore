defmodule TheScoreWeb.PlayerLive.Index do
  @moduledoc false

  use TheScoreWeb, :live_view

  alias TheScore.Statistics

  @impl true
  def mount(_params, _session, socket) do
    socket = 
      socket
      |> assign(:players, [])
      |> assign(:player_name, "")
      |> assign(:sort_field, "name")
      |> assign(:sort_direction, "asc")
      |> assign(:update_action, "append")

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_number, 1)
    |> get_players_page()
  end

  @impl true
  def handle_event("filter-by-player-name", %{"_target" => ["player_name"], "player_name" => player_name}, socket) do
    socket = 
      socket
      |> assign(:page_number, 1)
      |> assign(:player_name, player_name)
      |> assign(:update_action, "replace")
      |> get_players_page()

    {:noreply, socket}
  end

  @impl true
  def handle_event("sort", %{"sort" => field}, socket) do
    direction = 
      case socket do
        %{assigns: %{sort_direction: "asc"}} ->
          "desc"

        _ ->
          "asc"
      end

    socket = 
      socket
      |> assign(:page_number, 1)
      |> assign(:sort_field, field)
      |> assign(:sort_direction, direction)
      |> assign(:update_action, "replace")
      |> get_players_page()

    {:noreply, socket}
  end

  @impl true
  def handle_event("load-more-players", _params, socket) do
    socket = 
      socket
      |> assign(:update_action, "append")
      |> get_players_page()

    {:noreply, update(socket, :page_number, &(&1 + 1)) |> get_players_page()}
  end

  defp get_players_page(%{assigns: assigns = %{page_number: page_number}} = socket) do
    params =
      if assigns.player_name in [nil, ""] do
        %{page_size: 100, page: page_number}
      else
        %{page_size: 100, page: page_number, name: assigns.player_name}
      end
      |> Map.put("sort_field", assigns.sort_field)
      |> Map.put("sort_direction", assigns.sort_direction)

    assign(socket, players: Statistics.get_players_page(params))
  end
end
