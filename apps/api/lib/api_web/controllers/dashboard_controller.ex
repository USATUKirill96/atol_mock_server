defmodule ApiWeb.DashboardController do
  @moduledoc """
    Дашборд служит для предоставления информации о состоянии устройства ККТ

    Он выводит информацию о поступивших запросах от клиентской стороны, а также возникших ошибках
  """

  use ApiWeb, :controller
  require Logger

  def index(conn, _params) do
    events =
      Dashboard.get()
      |> Enum.map(fn action -> match_event_color(action) end)

    conn
    |> render("dashboard.html", events: events)
  end

  @spec match_event_color(Dashboard.Action.t()) :: %{
          action: Dashboard.Action.t(),
          color: String.t()
        }
  def match_event_color(action) do
    rules = %{api_events: "#bdf2bb", errors: "#fe7f66"}

    %{action: action, color: rules[action.type]}
  end

  def create(conn, _params) do
    Dashboard.clean()
    conn
    |> put_flash(:info, "Логи очищены")
    |> redirect(to: "/")
  end
end
