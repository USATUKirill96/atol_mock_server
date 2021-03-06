defmodule ApiWeb.Settings.DeviceController do
  use ApiWeb, :controller
  alias Atol.Devices
  def index(conn, _params) do

    device = Devices.get()

    params = %{
      serial: device.serial,
      cashier: device.parameters[122],
      vatin: device.parameters[150]
    }

    conn
    |> render("device.html", params: params)
  end

  def create(conn, params) do
    device = Devices.get()

    # Обновить настройки устройства
    %{
      serial: params["serial"],
      parameters: %{device.parameters | 122 => params["cashier"], 150 => params["vatin"]}
    }
    |>Devices.update()

    # Вернуть ответ пользователю
    conn
    |> put_flash(:info, "Настройки сохранены")
    |> redirect(to: "/settings/device")
  end
end
