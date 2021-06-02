defmodule TheScore.StatisticsTest do
  use TheScore.DataCase

  alias TheScore.Statistics
  alias TheScore.Statistics.Player

  describe "list_players/0" do
    @statistics_list_players
    test "when have no players returns an empty list"

    @statistics_list_players
    test "when has players returns a list containing all"
  end

  describe "get_player/1" do
    @statistics_get_player
    test "when player_id match with existing player returns they statistics"

    @statistics_get_player
    test "when player_id doesn't match with existing player returns an error"
  end

  describe "create_player/1" do
    @statistics_create_player
    test "with valid data creates a player"

    @statistics_create_player
    test "with invalid data returns an error"
  end

  describe "update_player/1" do
    @statistics_update_player
    test "with valid data creates a player"

    @statistics_update_player
    test "with invalid data returns an error"
  end

  describe "delete_player/1" do
    @statistics_delete_player
    test "set the player status to DELETED"
  end

  describe "change_player/1" do
    @statistics_change_player
    test "returns a player changeset" do
      #assert %Ecto.Changeset{} = Statistics.change_player(player)
    end
  end
end

