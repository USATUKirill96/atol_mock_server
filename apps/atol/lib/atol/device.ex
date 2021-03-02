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

    # Возможные параметры ККТ
    parameters = %{
    122 => Settings.Shift.get().operator
    }

    keys
    |>Enum.map(fn key ->  %{"key" => key, "value" =>Map.get(parameters, key)} end)
    |>IO.inspect(label: "Оператор смены")
    |>Tasks.add(uuid)
  end
end