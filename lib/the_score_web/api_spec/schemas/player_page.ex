defmodule TheScore.ApiSpec.Schemas.PlayerPage do
  @moduledoc false

  require OpenApiSpex

  alias OpenApiSpex.Schema
  alias OpenApiSpex.Reference

  OpenApiSpex.schema(%{
    title: "PlayerPage",
    description: "A page with many Players",
    type: :object,
    properties: %{
      entries: %Schema{
        type: :array,
        items: %Reference{
          "$ref": "#/components/schemas/PlayerResponse"
        }
      },
      page_size: %Schema{
        type: :integer,
        default: 20,
        description: "Requested page size"
      },
      page_number: %Schema{
        type: :integer,
        default: 1,
        description: "Page requested in request"
      },
      total_pages: %Schema{
        type: :integer,
        description: "Total number of pages"
      },
      total_entries: %Schema{
        type: :integer,
        description: "Total number of entries in all pages"
      },
    },
    required: [
      :entries,
      :page_size,
      :page_number,
      :total_pages,
      :total_entries
    ],
    example: %{
      page_size: 10,
      page_number: 1,
      total_pages: 1,
      total_entries: 1,
      entries: [
        %{
          id: "afe451ec-f213-4e01-91bf-baa522135624",
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
      ]
    }
  })
end
