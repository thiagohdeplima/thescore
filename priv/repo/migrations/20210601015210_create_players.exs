defmodule TheScore.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :name, :string, null: false, description: "Players name"
      add :team, :string, null: false, description: "Player's team abbreviation"
      add :pos,  :string, null: false, description: "Pos (Player's postion)"

      add :attg,    :float,  null: false, description: "Att/G (Rushing Attempts Per Game Average)"
      add :att,     :float,  null: false, description: "Att (Rushing Attempts)"
      add :yds,     :float,  null: false, description: "Yds (Total Rushing Yards)"
      add :avg,     :float,  null: false, description: "Avg (Rushing Average Yards Per Attempt)"
      add :ydsg,    :float,  null: false, description: "Yds/G (Rushing Yards Per Game)"
      add :td,      :float,  null: false, description: "TD (Total Rushing Touchdowns)"
      add :lng,     :string, null: false, description: "Lng (Longest Rush -- a T represents a touchdown occurred)"
      add :r1st,    :float,  null: false, description: "1st (Rushing First Downs)"
      add :r1stp,   :float,  null: false, description: "1st% (Rushing First Down Percentage)"
      add :r20plus, :float,  null: false, description: "20+ (Rushing 20+ Yards Each)"
      add :r40plus, :float,  null: false, description: "40+ (Rushing 40+ Yards Each)"
      add :fum,     :float,  null: false, description: "FUM (Rushing Fumbles)"

      timestamps()
    end

  end
end
