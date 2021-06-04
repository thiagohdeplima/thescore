defmodule TheScoreWeb.PlayerLiveTest do
  use TheScoreWeb.ConnCase

  import Phoenix.LiveViewTest

  import TheScore.Statistics.Factory

  setup do
    {:ok, TheScore.Repo.scrivener_defaults()}
  end

  setup %{page_size: page_size} do
    {:ok, players: insert_list(page_size, :player)}
  end

  describe "/players" do
    test "render the first players page", %{conn: conn, players: players} do
      {:ok, _index_live, html} = live(conn, Routes.player_index_path(conn, :index))

      Enum.each(players, fn player ->
        assert html =~ player.name
      end)
    end

    test "filters player by name", %{conn: conn, players: players} do
      {:ok, view, _html} = live(conn, Routes.player_index_path(conn, :index))

      last_player_name = List.last(players).name

      event = "filter-by-player-name"

      value = %{
        "_target" => ["player_name"],
        "player_name" => last_player_name
      }        

      Enum.each(players, fn
        %{name: ^last_player_name} ->
          assert render_change(view, event, value) =~ last_player_name

        player -> 
          refute render_change(view, event, value) =~ player.name
      end)
    end
  end
end
