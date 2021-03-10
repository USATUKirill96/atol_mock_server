defmodule ApiWeb.Router do
  @moduledoc false

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

  # KKT Dashboard
  scope "/", ApiWeb do
    pipe_through :browser
    get "/", DashboardController, :index
  end

  # KKT Settings
  scope "/settings", ApiWeb do
    pipe_through :browser

    resources "/shift", Settings.ShiftController, only: [:index, :create]
    resources "/device", Settings.DeviceController, only: [:index, :create]
    resources "/fiscal_storage", Settings.FiscalStorageController, only: [:index, :create]
  end

  # KKT API
  scope "/requests", ApiWeb do
    pipe_through :api

    post "/", RequestController, :create
    get "/*uuid", ResultController, :index
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
    end
  end
end
