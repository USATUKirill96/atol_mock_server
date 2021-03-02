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
    get "/", DashboardController, :index
  end

  scope "/settings", ApiWeb do
    pipe_through :browser

    get "/shift", Settings.ShiftController, :index
    post "/shift", Settings.ShiftController, :update

    get "/device", Settings.DeviceController, :index
    post "/device", Settings.DeviceController, :update
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
