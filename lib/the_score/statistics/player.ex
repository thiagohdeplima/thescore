defmodule TheScore.Statistics.Player do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "players" do
    field :name, :string
    field :team, :string
    field :pos,  :string

    field :attg,  :float
    field :att,   :float
    field :yds,   :float
    field :avg,   :float
    field :ydsg,  :float
    field :td,    :float
    field :lng,   :string
    field :r1st,  :float
    field :r1stp, :float
    
    field :r20plus, :float
    field :r40plus, :float

    field :fum, :float

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, fields())
    |> validate_required(fields())
  end

  defp fields do
    __MODULE__.__schema__(:fields)
    |> Enum.filter(fn field ->
      not Enum.member?([:id, :inserted_at, :updated_at], field)
    end)
  end
end
