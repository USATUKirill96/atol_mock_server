defmodule ApiWeb.Settings.FiscalStorageController do
  @moduledoc false

  use ApiWeb, :controller

  def index(conn, _params) do
    data = %{settings: Atol.get_fiscal_storage(), meta: Atol.FiscalStorages.LivePhases.get()}

    conn
    |> render("fiscal_storage.html", data: data)
  end

  def create(conn, params) do
    # Сохранить настройки
    params
    |> Atol.update_fiscal_storage()

    # Вернуть ответ пользователю
    conn
    |> put_flash(:info, "Настройки сохранены")
    |> redirect(to: "/settings/fiscal_storage")
  end
end
