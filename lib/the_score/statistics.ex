defmodule TheScore.Statistics do
  @moduledoc """
  The Statistics context.
  """

  import Ecto.Query, warn: false

  alias TheScore.Repo
  alias TheScore.Statistics.Player

  @type player :: %Player{}

  @doc """
  Return an `Scrivener.Page` of players.

  ## Examples

      iex> get_players_page()
      Scrivener.Page{entries: [%Player{}, ...]}
  """
  @spec get_players_page(map) :: Scrivener.Page.t(player)
  def get_players_page(params \\ %{})

  def get_players_page(%{page_size: page_size})
      when page_size > 200 do
    {:error, :page_size_exceeded}
  end

  def get_players_page(%{"page_size" => page_size})
      when page_size > 200 do
    {:error, :page_size_exceeded}
  end

  def get_players_page(%{"name" => name} = params) do
    from(Player)
    |> where([p], like(p.name, ^"#{name}%"))
    |> order_by(asc: :name)
    |> Repo.paginate(params)
  end

  def get_players_page(%{name: name} = params) do
    from(Player)
    |> where([p], ilike(p.name, ^"#{name}%"))
    |> order_by(asc: :name)
    |> Repo.paginate(params)
  end

  def get_players_page(params) do
    from(Player)
    |> page_ordenation(params)
    |> Repo.paginate(params)
  end

  defp page_ordenation(query, %{"sort_field" => field, "sort_direction" => direction}) do
    case {field, direction} do
      {"yds", "asc"} ->
        order_by(query, asc: :yds)

      {"yds", "desc"} ->
        order_by(query, desc: :yds)

      {"td", "asc"} ->
        order_by(query, asc: :td)

      {"td", "desc"} ->
        order_by(query, desc: :td)

      {"lng", "asc"} ->
        order_by(query, fragment("SUBSTRING(lng FROM ?)::INT ASC", "(-?[0-9]+)"))

      {"lng", "desc"} ->
        order_by(query, fragment("SUBSTRING(lng FROM ?)::INT DESC", "(-?[0-9]+)"))

      _other ->
        order_by(query, asc: :name)
    end
  end

  defp page_ordenation(query, _),
    do: order_by(query, asc: :name)

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  @spec list_players() :: list(player)
  def list_players do
    Repo.all(Player)
  end

  @doc """
  Gets a single player by their ID.
  """
  @spec get_player(Ecto.UUID.t()) ::
          {:ok, player} | {:error, :player_not_found}
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
          {:ok, player} | {:error, Ecto.Changeset.t()}
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
  @spec update_player(Ecto.UUID.t(), map) ::
          {:ok, player} | {:error, atom}
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

  @spec get_total_yds_by_team() :: list(map)
  def get_total_yds_by_team() do
    from(p in Player, select: {p.team, sum(p.yds)})
    |> group_by([p], p.team)
    |> Repo.all()
    |> Enum.map(fn {team, yds} ->
      %{team: team, yds: yds}
    end)
  end
end
