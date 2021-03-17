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
    input_data
    |> Enum.reduce(device.parameters, fn(data, parameters) -> Map.put(parameters, data["key"], data["value"]) end)
  end
end
