defmodule Atol.Devices.Device do
  alias Atol.Tasks
  alias __MODULE__

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

  def get_info() do

    %{serial: 12345678}
    |>Device.new()
  end


end
