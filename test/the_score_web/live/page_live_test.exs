defmodule TheScoreWeb.PageLiveTest do
  use TheScoreWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")

    assert disconnected_html =~ "Welcome to The Rush"
    assert render(page_live) =~ "Welcome to The Rush"
  end
end
