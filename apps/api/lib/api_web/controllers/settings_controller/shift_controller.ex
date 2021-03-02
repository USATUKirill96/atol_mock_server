defmodule ApiWeb.Settings.ShiftController do
  use ApiWeb, :controller


  def index(conn, _params) do
    settings = Settings.Shift.get()
  conn
    |>render("shift.html", settings: settings)
  end


  def update(conn, params) do
    params
    |>to_struct()
    |>Settings.Shift.update()

    conn
    |>put_flash(:info, "Настройки сохранены")
    |>redirect(to: "/settings/shift")
  end

  defp to_struct(settings) do
    %Settings.Shift{
      operator: settings["operator"],
      number: settings["number"],
      state: settings["settings"]
    }
  end

end
