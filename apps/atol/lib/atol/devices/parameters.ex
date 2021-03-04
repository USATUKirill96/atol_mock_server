defmodule Atol.Devices.Parameters do
  alias Atol.Devices.State
  alias Atol.Tasks

  def get_parameters(uuid, keys) do

    parameters = for {k, v} <- State.get(:parameters), k in keys, do: %{"key" => k, "value" => v}

    %{"deviceParameters" => parameters}
    |> Tasks.add(uuid)
  end


  def set_parameters(uuid, input_data) do

    # Обновить параметры устройства
    State.get(:parameters)
    |>update_parameters(input_data)
    |>State.update(:parameters)

    # Создать задачу
    %{"deviceParameters" => input_data}
    |> Tasks.add(uuid)
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