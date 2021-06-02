defmodule TheScore.Statistics do
  @moduledoc """
  The Statistics context.
  """

  import Ecto.Query, warn: false

  alias TheScore.Repo
  alias TheScore.Statistics.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  @spec list_players() :: list(%Player{})
  def list_players do
    Repo.all(Player)
  end

  @doc """
  Gets a single player by their ID.
  """
  @spec get_player(Ecto.UUID.t) ::
    {:ok, %Player{}} | {:error, :player_not_found}
  def get_player(id) do
    Repo.get(Player, id)
    |> case do
      nil ->
        {:error, :player_not_found}

      player ->
        {:ok, player}
    end
  end

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(attrs)
      {:ok, %Player{}}

      iex> create_player(wrong_attrs)
      {:error, %Ecto.Changeset{}}

  """
  @spec create_player(map) ::
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player_id, %{attg: 1})
      {:ok, %Player{}}

      iex> update_player(player_id, %{attg: bad_value})
      {:error, %Ecto.Changeset{}}

      iex> update_player(inexistent_player_id, %{attg: 1})
      {:error, :player_not_found}

  """
  @spec update_player(Ecto.UUID.t, map) ::
    {:ok, %Player{}} | {:error, atom}
  def update_player(player_id, attrs) do
    case get_player(player_id) do
      {:error, reason} ->
        {:error, reason}

      {:ok, player} ->
        player
        |> Player.changeset(attrs)
        |> Repo.update()
    end
  end

  @doc """
  Deletes a player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{data: %Player{}}

  """
  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end
end
