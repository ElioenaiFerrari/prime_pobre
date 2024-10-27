defmodule PrimePobreWeb.Router do
  use PrimePobreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PrimePobreWeb do
    pipe_through :api

    get "/movies/:id/stream", MovieController, :stream
    get "/movies", MovieController, :index
    get "/series", SerieController, :index
    get "/series/:id", SerieController, :show
    get "/series/:id/seasons", SerieSeasonController, :index
    get "/series/:serie_id/seasons/:id", SerieSeasonController, :show
    get "/series/:serie_id/seasons/:id/episodes", SerieSeasonEpisodeController, :index

    get "/series/:serie_id/seasons/:season_id/episodes/:id/stream",
        SerieSeasonEpisodeController,
        :stream
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:prime_pobre, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: PrimePobreWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
