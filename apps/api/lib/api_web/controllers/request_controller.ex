defmodule ApiWeb.RequestController do
  use ApiWeb, :controller
  require Logger
  alias Atol.{Checks, Devices, FiscalStorages, Reports, Shifts}

  def create(conn, params) do
    route(params)

    conn
    |> put_status(200)
    |> json(%{"status" => "ok"})
  end

  defp route(params) do
    %{"request" => %{"type" => type}, "uuid" => uuid} = params

    case type do
      "getShiftStatus" -> Shifts.get_status(uuid)
      "getFnInfo" -> FiscalStorages.get_info(uuid)
      "getDeviceInfo" -> Devices.get_info(uuid)
      "getDeviceParameters" -> Devices.get_parameters(uuid, keys(params))
      "setDeviceParameters" -> Devices.set_parameters(uuid, device_parameters(params))
      "sell" -> Checks.sell(uuid)
      "sellReturn" -> Checks.sell_return(uuid)
      "continuePrint" -> Checks.continue_print(uuid)
      "reportX" -> Reports.print_report_x(uuid)
      "openShift" -> Shifts.open(uuid, name(params))
      "closeShift" -> Shifts.close(uuid)
      _ -> Logger.warning("Неизвестный запрос")
    end
  end

  def keys(%{"request" => %{"keys" => keys}}) do
    keys
  end

  def name(%{"request" => %{"operator" => %{"name" => name}}}) do
    name
  end

  def device_parameters(%{"request" => %{"deviceParameters" => parameters}}) do
    parameters
  end
end
