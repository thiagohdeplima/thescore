defmodule TheScore.StatisticsTest do
  use TheScore.DataCase

  use ExUnitProperties

  alias TheScore.Statistics
  alias TheScore.Statistics.Player

  import TheScore.Statistics.Factory

  describe "list_players/0" do
    @tag :statistics_list_players
    test "when have no players returns an empty list" do
      assert Statistics.list_players() == []
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
    test "when player_id match with existing player returns they statistics", %{
      player: %{id: player_id}
    } do
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
    test "when player name already exists returns an error", %{data: data} do
      %Player{name: name} = insert(:player)

      assert {:error, %Ecto.Changeset{errors: [{:name, {"has already been taken", _}}]}} =
               Statistics.create_player(Map.put(data, :name, name))
    end

    @tag :statistics_create_player
    test "with valid data creates a player", %{data: data} do
      assert {:ok, %Player{}} = Statistics.create_player(data)
    end

    @tag :statistics_create_player
    test "with missing data returns an error", %{data: data} do
      Map.keys(data)
      |> Enum.each(fn key ->
        assert {:error, %Ecto.Changeset{errors: [{^key, {"can't be blank", _}}]}} =
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
    test "with valid data updates a player", %{data: data, player: %{id: player_id}} do
      assert {:ok, %Player{id: ^player_id}} = Statistics.update_player(player_id, data)
    end

    @tag :statistics_update_player
    test "with invalid data returns an error", %{player: %{id: player_id}} do
      Enum.each(Player.__schema__(:fields), fn field ->
        case Player.__schema__(:type, field) do
          :string ->
            assert {:error, %Ecto.Changeset{errors: [{^field, {"is invalid", _}}]}} =
                     Statistics.update_player(player_id, %{field => Enum.random([1..1000])})

          :float ->
            assert {:error, %Ecto.Changeset{errors: [{^field, {"is invalid", _}}]}} =
                     Statistics.update_player(player_id, %{field => Faker.Person.name()})

          _other ->
            :next
        end
      end)
    end

    @tag :statistics_update_player
    test "when player doesn't exists returns an error", %{data: data} do
      assert {:error, :player_not_found} =
               Ecto.UUID.generate()
               |> Statistics.update_player(data)
    end
  end

  describe "get_players_page/1" do
    @tag :get_players_page
    test "when have no players returns a empty page" do
      assert %Scrivener.Page{total_entries: 0} =
        Statistics.get_players_page()
    end

    @tag :get_players_page
    test "returns a page of players" do
      insert_list(50, :player)

      assert %Scrivener.Page{entries: players, total_entries: total_entries} =
        Statistics.get_players_page()

      assert 50 == total_entries

      assert [%Player{} | _] = players
    end

    @tag :get_players_page
    property "changes page_size according params" do
      check all page_size <- integer(1..100) do
        assert %Scrivener.Page{page_size: ^page_size} =
          Statistics.get_players_page(%{"page_size" => page_size})
      end
    end

    @tag :get_players_page
    property "when page_size is greather than 200 returns error" do
      check all page_size <- integer(201..1_000_000) do
        assert {:error, :page_size_exceeded} =
          Statistics.get_players_page(%{"page_size" => page_size})
      end
    end
  end
end
