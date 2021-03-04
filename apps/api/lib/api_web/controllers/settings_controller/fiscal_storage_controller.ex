defmodule ApiWeb.Settings.FiscalStorageController do
  use ApiWeb, :controller

  def index(conn, _params) do
    data = %{settings: Settings.FiscalStorage.get(), meta: Settings.FiscalStorage.live_phases()}

    conn
    |> render("fiscal_storage.html", data: data)
  end

  def create(conn, params) do
    # Сохранить настройки
    params
    |> Settings.FiscalStorage.new()
    |> Settings.FiscalStorage.update()

    # Вернуть ответ пользователю
    conn
    |> put_flash(:info, "Настройки сохранены")
    |> redirect(to: "/settings/fiscal_storage")
  end
end
