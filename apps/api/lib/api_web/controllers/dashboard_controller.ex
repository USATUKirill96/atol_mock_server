defmodule ApiWeb.DashboardController do
  use ApiWeb, :controller
  require Logger

  def index(conn, _params) do
    events =
      Dashboard.get()
      |> Enum.map(fn action -> match_event_color(action) end)

    conn
    |> render("dashboard.html", events: events)
  end

  defp match_event_color(action) do
    rules = %{api_events: "#bdf2bb", errors: "#fe7f66"}

    %{action: action, color: rules[action.type]}
  end
end
