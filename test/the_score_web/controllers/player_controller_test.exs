defmodule TheScoreWeb.PlayerControllerTest do
  use TheScoreWeb.ConnCase

  import TheScore.Statistics.Factory

  import OpenApiSpex.TestAssertions

  alias TheScore.ApiSpec.Schemas.PlayerPage
  alias TheScore.ApiSpec.Schemas.PlayerResponse

  alias TheScore.Statistics.Player

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  setup do
    {:ok, players: insert_list(50, :player)}
  end

  setup do
    {:ok,
      api_spec: TheScoreWeb.ApiSpec.spec(),
      page_schema: PlayerPage.schema(),
      player_schema: PlayerResponse.schema()
    }
  end

  describe "GET /api/players" do
    @tag :web
    @tag :api_get_players
    test "documentation must match with schema", %{api_spec: api_spec, page_schema: page_schema} do
      assert_schema(page_schema.example, "PlayerPage", api_spec)
    end

    @tag :api_get_players
    test "returns a players page according schema", %{api_spec: api_spec, conn: conn} do
      path = Routes.player_path(conn, :index)
      conn = get(conn, path)
      json = json_response(conn, 200)

      assert_schema(json, "PlayerPage", api_spec)
    end
  end

  describe "GET /api/players/:player_id" do
    setup %{players: [player | _]} do
      {:ok, player: player}
    end

    @tag :web
    @tag :api_get_player_by_id
    test "documentation must match with schema", %{api_spec: api_spec, player_schema: player_schema} do
      assert_schema(player_schema.example, "PlayerResponse", api_spec)
    end

    @tag :web
    @tag :api_get_player_by_id
    test "returns the player matching with ID", %{player: %{name: player_name, id: player_id}, api_spec: api_spec, conn: conn} do
      path = Routes.player_path(conn, :show, player_id)
      conn = get(conn, path)
      json = json_response(conn, 200)

      assert json["name"] == player_name

      assert_schema(json, "PlayerResponse", api_spec)
    end

    @tag :web
    @tag :api_get_player_by_id
    test "returns 404 when players doesn't exists", %{player: player = %{id: player_id}, api_spec: api_spec, conn: conn} do
      path = Routes.player_path(conn, :show, Ecto.UUID.generate())
      conn = get(conn, path)
      
      assert json_response(conn, 404)
    end
  end
end
