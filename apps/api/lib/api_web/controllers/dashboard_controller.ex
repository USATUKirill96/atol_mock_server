defmodule ApiWeb.DashboardController do
  use ApiWeb, :controller
  require Logger

  def index(conn, _params) do
    conn
    |> render("dashboard.html")
  end
end
