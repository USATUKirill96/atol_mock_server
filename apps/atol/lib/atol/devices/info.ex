defmodule Atol.Devices.Info do
  alias __MODULE__

  defstruct configuration_version: "5.4.3-rc4",
            ffd_version: "1.05",
            firmware_version: "1245",
            fn_ffd_version: "1.0",
            model: 69,
            model_name: "АТОЛ 77Ф",
            receipt_line_length: 48,
            receipt_line_lengthPix: 576,
            serial: "9232278066186"

  use ExConstructor

  def from_device(device) do

    %{serial: device.serial}
    |>Info.new()
  end


end
