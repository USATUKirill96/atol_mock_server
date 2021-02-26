defmodule ApiWeb.SettingsController do
  use ApiWeb, :controller

  def index(conn, _params) do

    settings = Settings.get()
    conn
    |>render("settings.html", settings: settings)
  end


  def update(conn, params) do
    params
    |>to_struct()
    |>Settings.update()

    conn
    |>put_flash(:info, "Настройки сохранены")
    |>redirect(to: "/")
  end

  defp to_struct(settings) do
    %Settings{
    cashier: settings["cashier"]
    }

  end
end
