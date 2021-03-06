defmodule Atol.Devices.Parameters do

  def update(device, input_data) do
    # Обновить параметры устройства
    device.parameters
    |>update_req(input_data)
  end

  defp update_req(parameters, []) do
    parameters
  end

  defp update_req(parameters, [head | tail]) do
    parameters
    |> Map.put(head["key"], head["value"])
    |> update_req(tail)
  end

end