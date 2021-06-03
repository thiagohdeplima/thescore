defmodule TheScore.ApiSpec.Operations.Player do
  @moduledoc false

  alias OpenApiSpex.Operation
  alias OpenApiSpex.Parameter

  alias TheScore.ApiSpec.Schemas.PlayerPage
  alias TheScore.ApiSpec.Schemas.PlayerResponse

  @spec open_api_operation(atom) :: Operation.t()
  def open_api_operation(action) do
    apply(__MODULE__, action, [])
  end

  @spec index() :: Operation.t()
  def index() do
    %Operation{
      tags: ["players"],
      summary: "List players and their statistics",
      description: "List players and their statistics",
      operationId: "PlayerController.index",
      parameters: [
        %Parameter{
          in: :query,
          name: "page_size",
          description: "Max players in page"
        },

        %Parameter{
          in: :query,
          name: "page_number",
          description: "Desired page number"
        }
      ],
      responses: %{
        200 => Operation.response("PlayerPage", "application/json", PlayerPage)
      }
    }
  end

  @spec show() :: Operation.t()
  def show() do
    %Operation{
      tags: ["players"],
      summary: "List players and their statistics",
      description: "List players and their statistics",
      operationId: "PlayerController.show",
      parameters: [
        %Parameter{
          in: :path,
          name: "player_id",
          description: "The player's ID"
        }
      ],
      responses: %{
        200 => Operation.response("PlayerResponse", "application/json", PlayerResponse)
      }
    }
  end
end