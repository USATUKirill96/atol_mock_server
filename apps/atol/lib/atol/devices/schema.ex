defmodule Atol.Devices.Schema do
  def get_parameters(device, keys) do
    parameters = for {k, v} <- device.parameters, k in keys, do: %{"key" => k, "value" => v}
    %{"deviceParameters" => parameters}
  end

  def set_parameters(input_data) do
    %{"deviceParameters" => input_data}
  end

  def get_info(info) do
    device_info_body =
      info
      |> Map.from_struct()
      |> Recase.Enumerable.convert_keys(&Recase.to_camel/1)

    %{"deviceInfo" => device_info_body}
  end
end
