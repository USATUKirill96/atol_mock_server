defmodule ApiWeb.Settings.DeviceController do
  use ApiWeb, :controller


  def index(conn, _params) do
    device = Settings.Device.get()
    params = %{serial: device.serial, cashier: device.parameters[122], vatin: device.parameters[150]}
  conn
    |>render("device.html", params: params)
  end


  def update(conn, params) do
    device_parameters = Settings.Device.get().parameters

    %Settings.Device{
      serial: params["serial"],
      parameters: %{device_parameters | 122 => params["cashier"], 150 => params["vatin"]}
    }
    |>Settings.Device.update()

    conn
    |>put_flash(:info, "Настройки сохранены")
    |>redirect(to: "/settings/device")
  end

  defp to_struct(settings) do
    %Settings.Device{
      serial: settings["serial"]
    }
  end

end
