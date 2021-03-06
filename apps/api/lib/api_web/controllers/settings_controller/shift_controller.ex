defmodule ApiWeb.Settings.ShiftController do
  use ApiWeb, :controller

  def index(conn, _params) do
    shift = Atol.Shifts.get()

    conn
    |> render("shift.html", shift: shift)
  end

  def create(conn, params) do
    # Сохранить настройки
    {_, data} = params
                 |>Map.pop("_csrf_token")
    data
    |>Atol.Shifts.Shift.new()
    |> Atol.Shifts.update()

    # Вернуть ответ пользователю
    conn
    |> put_flash(:info, "Настройки сохранены")
    |> redirect(to: "/settings/shift")
  end
end
