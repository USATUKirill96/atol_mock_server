defmodule Atol.Device do

  def get_info(uuid) do

    parameters = Settings.Device.get()

    %{
      "deviceInfo" => %{
        "configurationVersion" => "5.4.3-rc4",
        "ffdVersion" => "1.05",
        "firmwareVersion" => "1245",
        "fnFfdVersion" => "1.0",
        "model" => 69,
        "modelName" => "АТОЛ 77Ф",
        "receiptLineLength" => 48,
        "receiptLineLengthPix" => 576,
        "serial" => parameters.serial
      }
    }
    |>Tasks.add(uuid)
  end


  def get_parameters(uuid, keys) do

    parameters = for {k, v} <- Settings.Device.get().parameters, k in keys, do: %{"key" => k, "value" => v}
    %{"deviceParameters" => parameters}
    |>Tasks.add(uuid)
  end


  def set_parameters(uuid, input_data) do
    # Обновить параметры устройства
    settings = Settings.Device.get()
    updated_parameters = update_parameters(settings.parameters, input_data)

    # Сохранить состояние
    %{settings | parameters: updated_parameters}
    |>Settings.Device.update()

    # Создать задачу
    %{"deviceParameters" =>input_data}
    |>Tasks.add(uuid)
  end


  def update_parameters(parameters, []) do parameters end

  def update_parameters(parameters, [head | tail]) do
    parameters
    |>Map.put(head["key"], head["value"])
    |>update_parameters(tail)
  end

end