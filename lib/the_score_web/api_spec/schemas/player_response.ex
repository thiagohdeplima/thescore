defmodule TheScore.ApiSpec.Schemas.PlayerResponse do
  @moduledoc false

  require OpenApiSpex

  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "PlayerResponse",
    description: "A player and their statistics",
    type: :object,
    properties: %{
      id: %Schema{
        type: :uuid
      },
      name: %Schema{
        type: :string,
        description: "Player's name"
      },
      team: %Schema{
        type: :string,
        description: "Player's team abbreviation"
      },
      pos: %Schema{
        type: :string,
        description: "Player's postion"
      },
      attg: %Schema{
        type: :float,
        description: "Rushing Attempts Per Game Average"
      },
      att: %Schema{
        type: :float,
        description: "Rushing Attempts"
      },
      yds: %Schema{
        type: :float,
        description: "Total Rushing Yards"
      },
      avg: %Schema{
        type: :float,
        description: "Rushing Average Yards Per Attempt"
      },
      ydsg: %Schema{
        type: :float,
        description: "Rushing Yards Per Game"
      },
      td: %Schema{
        type: :float,
        description: "Total Rushing Touchdowns"
      },
      lng: %Schema{
        type: :string,
        description: "Longest Rush -- a T represents a touchdown occurred",
        pattern: ~r/(\d+){1,}.(\d+){1,}(T)?/
      },
      r1st: %Schema{
        type: :float,
        description: "Rushing First Downs"
      },
      r1stp: %Schema{
        type: :float,
        description: "Rushing First Down Percentage"
      },
      r20plus: %Schema{
        type: :float,
        description: "Rushing 20+ Yards Each"
      },
      r40plus: %Schema{
        type: :float,
        description: "Rushing 40+ Yards Each"
      },
      fum: %Schema{
        type: :float,
        description: "Rushing Fumbl"
      }
    },
    example: %{
      name: "Kenyan Drake",
      team: "MIA",
      pos: "RB",
      attg: 33,
      att: 2.1,
      yds: 179,
      avg: 5.4,
      ydsg: 11.2,
      td: 2,
      lng: "45T",
      r1st: 9,
      r1stp: 27.3,
      r20plus: 1,
      r40plus: 1,
      fum: 0
    }
  })
end
