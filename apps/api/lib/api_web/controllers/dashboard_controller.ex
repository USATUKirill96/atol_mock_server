defmodule ApiWeb.DashboardController do
  use ApiWeb, :controller
  require Logger

  def index(conn, _params) do
    actions = Dashboard.get()
    conn
    |> render("dashboard.html", actions: actions)
  end
end
