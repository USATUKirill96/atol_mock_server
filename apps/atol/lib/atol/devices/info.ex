defmodule Atol.Devices.Info do
  @moduledoc """
  Структура информации об устройстве и логика её формирования
  """

  alias __MODULE__
  alias Atol.Devices.Device

  @type t :: %__MODULE__{
          configuration_version: String.t(),
          ffd_version: String.t(),
          firmware_version: String.t(),
          fn_ffd_version: String.t(),
          model: integer,
          model_name: String.t(),
          receipt_line_length: integer,
          receipt_line_lengthPix: integer,
          serial: String.t()
        }

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

  @spec from_device(Device.t()) :: Info.t()
  def from_device(device) do
    %{serial: device.serial}
    |> Info.new()
  end
end
