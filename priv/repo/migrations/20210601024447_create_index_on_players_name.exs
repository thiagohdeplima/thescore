defmodule TheScore.Repo.Migrations.CreateIndexOnPlayersName do
  use Ecto.Migration

  def change do
    create unique_index(:players, :name)
  end
end
