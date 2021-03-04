defmodule ApiWeb.Settings.ShiftController do
  use ApiWeb, :controller

  def index(conn, _params) do
    settings = Settings.Shift.get()

    conn
    |> render("shift.html", settings: settings)
  end

  def create(conn, params) do
    # Сохранить настройки
    params
    |> Settings.Shift.new()
    |> Settings.Shift.update()

    # Вернуть ответ пользователю
    conn
    |> put_flash(:info, "Настройки сохранены")
    |> redirect(to: "/settings/shift")
  end
end
