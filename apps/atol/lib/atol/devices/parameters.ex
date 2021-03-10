defmodule Atol.Devices.Parameters do
  @moduledoc """
  Логика работы с параметрами устройства

  Сервер АТОЛ передает параметры устройства списком словарей [{"key" => 123, "value" => "value"}].
  Оперировать таким форматом проблематично, поэтому для хранения параметров преобразуем их в словарь вида
  {"key" => "value"}.
  """

  alias Atol.Devices.Device

  @spec update(Device.t(), list(map)) :: map
  def update(device, input_data) do
    # Обновить параметры устройства
    device.parameters
    |> update_req(input_data)
  end

  @spec update_req(map, list(map)) :: map
  defp update_req(parameters, []) do
    parameters
  end

  defp update_req(parameters, [head | tail]) do
    parameters
    |> Map.put(head["key"], head["value"])
    |> update_req(tail)
  end
end
