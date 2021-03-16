defmodule ApiWeb.Settings.DeviceController do
  @moduledoc false

  use ApiWeb, :controller

  def index(conn, _params) do
    device = Atol.get_device()

    params = %{
      serial: device.serial,
      cashier: device.parameters[122],
      vatin: device.parameters[150]
    }

    conn
    |> render("device.html", params: params)
  end

  def create(conn, params) do
    device = Atol.get_device()

    # Обновить настройки устройства
    %{
      serial: params["serial"],
      parameters: %{device.parameters | 122 => params["cashier"], 150 => params["vatin"]}
    }
    |> Atol.update_device()

    # Вернуть ответ пользователю
    conn
    |> put_flash(:info, "Настройки сохранены")
    |> redirect(to: "/settings/device")
  end
end
