defmodule Atol.Devices.Parameters do
  alias Atol.Devices.State

  def get_parameters(keys) do

    parameters = for {k, v} <- State.get(:parameters), k in keys, do: %{"key" => k, "value" => v}

    %{"deviceParameters" => parameters}
  end


  def set_parameters(input_data) do

    # Обновить параметры устройства
    State.get(:parameters)
    |>update_parameters(input_data)
    |>State.update(:parameters)

    # Создать задачу
    %{"deviceParameters" => input_data}
  end


  defp update_parameters(parameters, []) do
    parameters
  end

  defp update_parameters(parameters, [head | tail]) do
    parameters
    |> Map.put(head["key"], head["value"])
    |> update_parameters(tail)
  end

end