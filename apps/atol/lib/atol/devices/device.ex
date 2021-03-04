defmodule Atol.Devices.Device do
  alias Atol.Tasks

  defstruct configurationVersion: "5.4.3-rc4",
            ffdVersion: "1.05",
            firmwareVersion: "1245",
            fnFfdVersion: "1.0",
            model: 69,
            modelName: "АТОЛ 77Ф",
            receiptLineLength: 48,
            receiptLineLengthPix: 576,
            serial: "12345678"  # TODO: брать из настроек

  use ExConstructor

  def get_info(uuid) do

    %{serial: 12345678}
    |>Atol.Devices.Device.new()
    |> Tasks.add(uuid)
  end


end
