defmodule TheScore.StatisticsTest do
  use TheScore.DataCase

  alias TheScore.Statistics
  alias TheScore.Statistics.Player

  import TheScore.Statistics.Factory

  describe "list_players/0" do
    @tag :statistics_list_players
    test "when have no players returns an empty list" do
      assert Statistics.list_players == []
    end

    @tag :statistics_list_players
    test "when has players returns a list containing all" do
      assert %Player{id: player_id} = insert(:player)

      assert [%Player{id: ^player_id}] = Statistics.list_players()
    end
  end

  describe "get_player/1" do
    setup do
      {:ok, player: insert(:player)}
    end

    @tag :statistics_get_player
    test "when player_id match with existing player returns they statistics", %{player: %{id: player_id}} do
      assert {:ok, %Player{id: ^player_id}} = Statistics.get_player(player_id)
    end

    @tag :statistics_get_player
    test "when player_id doesn't match with existing player returns an error" do
      {:error, :player_not_found} =
        Ecto.UUID.generate()
        |> Statistics.get_player()
    end
  end

  describe "create_player/1" do
    setup do
      data = 
        build(:player)
        |> Map.from_struct()
        |> Map.drop([:__meta__, :id, :inserted_at, :updated_at])      
      
      {:ok, data: data}
    end

    @tag :statistics_create_player
    test "with valid data creates a player", %{data: data} do
      assert {:ok, %Player{}} = Statistics.create_player(data)
    end

    @tag :statistics_create_player
    test "with missing data returns an error", %{data: data} do
      Map.keys(data)
      |> Enum.each(fn key ->
          assert {:error, %Ecto.Changeset{errors: [{key, {"can't be blank", _}}]}} =
            Map.drop(data, [key])
            |> Statistics.create_player()
      end)
    end
  end

  describe "update_player/1" do
    setup do
      data = 
        build(:player)
        |> Map.from_struct()
        |> Map.drop([:__meta__, :id, :inserted_at, :updated_at])      
      
      {:ok, data: data}
    end

    setup do
      {:ok, player: insert(:player)}
    end

    @tag :statistics_update_player
    test "with valid data creates a player", %{data: data, player: %{id: player_id}} do
      assert {:ok, %Player{id: ^player_id}} = Statistics.update_player(player_id, data)
    end

    @tag :statistics_update_player
    test "with invalid data returns an error"

    @tag :statistics_update_player
    test "when player doesn't exists returns an error", %{data: data} do
      assert {:error, :player_not_found} =
        Ecto.UUID.generate()
        |> Statistics.update_player(data)
    end
  end

  describe "delete_player/1" do
    @tag :statistics_delete_player
    test "set the player status to DELETED"
  end

  describe "change_player/1" do
    setup do
      {:ok, player: insert(:player)}
    end

    @tag :statistics_change_player
    test "returns a player changeset", %{player: player} do
      assert %Ecto.Changeset{} = Statistics.change_player(player)
    end
  end
end

