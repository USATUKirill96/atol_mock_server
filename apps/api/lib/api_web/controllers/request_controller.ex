defmodule ApiWeb.RequestController do
  use ApiWeb, :controller
  require Logger

  def create(conn, params) do
    route(params)
    conn
      |>put_status(200)
      |>json(%{"status" => "ok"})
  end

  defp route(params) do
    %{"request" => %{"type" => type}, "uuid" => uuid} = params

    case type do
      "getShiftStatus" -> Atol.get_shift(uuid)
      "getFnInfo" -> Atol.get_fn_info(uuid)
      "getDeviceInfo" -> Atol.get_device_info(uuid)
      "getDeviceParameters" -> Atol.get_device_parameters(uuid, keys(params))
      "sell" -> Atol.sell(uuid)
      "sellReturn" -> Atol.sell_return(uuid)
      "continuePrint" -> Atol.continue_print(uuid)
      "reportX" -> Atol.print_report_x(uuid)
      "openShift" -> Atol.open_shift(uuid, name(params))
      "closeShift" -> Atol.close_shift(uuid)

      _ -> Logger.warning("Неизвестный запрос")

    end
  end

  def keys(%{"request" => %{"keys" => keys}}) do keys end
  def name(%{"request" => %{"operator" => %{"name" => name}}}) do name end

end
