defmodule ApiWeb.Settings.FiscalStorageController do
  @moduledoc false

  use ApiWeb, :controller
  alias Atol.FiscalStorages

  def index(conn, _params) do
    data = %{settings: FiscalStorages.get(), meta: FiscalStorages.live_phases()}

    conn
    |> render("fiscal_storage.html", data: data)
  end

  def create(conn, params) do
    # Сохранить настройки
    params
    |> FiscalStorages.update()

    # Вернуть ответ пользователю
    conn
    |> put_flash(:info, "Настройки сохранены")
    |> redirect(to: "/settings/fiscal_storage")
  end
end
