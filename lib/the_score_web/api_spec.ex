defmodule TheScoreWeb.ApiSpec do
  @moduledoc false

  alias OpenApiSpex.Info
  alias OpenApiSpex.OpenApi
  alias OpenApiSpex.Paths
  alias OpenApiSpex.Server

  alias TheScoreWeb.Endpoint
  alias TheScoreWeb.Router

  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      servers: [
        # Populate the Server info from a phoenix endpoint
        Server.from_endpoint(Endpoint)
      ],
      info: %Info{
        title: to_string(Application.spec(:the_score, :description)),
        version: to_string(Application.spec(:the_score, :vsn))
      },
      # Populate the paths from a phoenix router
      paths: Paths.from_router(Router)
    }
    |> OpenApiSpex.resolve_schema_modules() # Discover request/response schemas from path specs
  end
end