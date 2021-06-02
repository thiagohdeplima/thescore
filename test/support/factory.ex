defmodule TheScore.Statistics.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: TheScore.Repo

  alias Faker.Person
  alias Faker.Currency

  def player_factory() do
    %TheScore.Statistics.Player{
      name: Person.name(),
      team: Currency.code(),
      pos: Enum.random(~w(RB QB SS K NT FB P WR DB TE)),
      attg: Enum.random(1..322),
      att: Enum.random(1..218) / 10,
      yds: Enum.random(-23..997),
      avg: Enum.random(-115..600) / 10,
      ydsg: Enum.random(-60..1089) / 10,
      td: Enum.random(0..180) / 10,
      lng: "#{Enum.random(-1..9)}#{Enum.random(["T", ""])}",
      r1st: Enum.random(-60..1089) / 10,
      r1stp: Enum.random(-60..1089) / 10,
      r20plus: Enum.random(-60..1089) / 10,
      r40plus: Enum.random(-60..1089) / 10,
      fum: Enum.random(-60..1089) / 10
    }
  end
end
