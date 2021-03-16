defmodule ApiWeb.Settings.ShiftController do
  @moduledoc false

  use ApiWeb, :controller

  def index(conn, _params) do
    shift = Atol.get_shift()

    conn
    |> render("shift.html", shift: shift)
  end

  def create(conn, params) do
    # Сохранить настройки
    {_, data} =
      params
      |> Map.pop("_csrf_token")

    data
    |> Atol.update_shift()

    # Вернуть ответ пользователю
    conn
    |> put_flash(:info, "Настройки сохранены")
    |> redirect(to: "/settings/shift")
  end
end
