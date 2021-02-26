defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", ApiWeb do
    pipe_through :browser

    get "/", SettingsController, :index
    post "/", SettingsController, :update, singleton: true
  end

   scope "/requests", ApiWeb do
     pipe_through :api

     post "/", RequestController, :create
     get "/*uuid", ResultController, :show

  end


  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
    end
  end
end
