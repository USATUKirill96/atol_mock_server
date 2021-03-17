defmodule DeviceTest do
  alias Atol.Devices.{Device, Parameters, Schema, Info}
  use ExUnit.Case

  setup do
    # Параметры, как ими оперирует бизнес-логика
    parameters = %{122 => "John Doe", 150 => "7736207543"}
    # Параметры, как они отдаются и принимаются в API
    io_parameters = [%{"key" => 122, "value" => "John Doe"}, %{"key" => 150, "value" => "7736207543"}]
    {:ok, parameters: parameters, io_parameters: io_parameters}
  end

  test "get_device_struct", state do
    device = %{serial: "123456", parameters: state[:parameters]} |> Device.get()
    assert %Device{} = device
  end

  test "update_parameters", state do
    input_data = state[:io_parameters]
    updated_parameters = %Device{}
                         |>Parameters.update(input_data)
    assert updated_parameters == state[:parameters]
  end

  test "get_info", state do
    info = %{parameters: state[:parameters]}
              |> Device.get()
              |> Info.from_device()

    assert %Info{} = info
  end

  test "schema_get_parameters", state do
    schema = %{parameters: state[:parameters]}
             |> Device.get()
             |> Schema.get_parameters([122, 150])

    assert schema == %{"deviceParameters" => state[:io_parameters]}
  end

  test "schema_set_parameters", state do
    schema = Schema.set_parameters(state[:io_parameters])
    assert schema == %{"deviceParameters" => state[:io_parameters]}
  end

  test "schema_get_info", state do
    _schema = %{parameters: state[:parameters]}
             |> Device.get()
             |> Info.from_device()
             |> Schema.get_info()

    pattern = %{
      configurationVersion: "5.4.3-rc4",
      ffdVersion: "1.05",
      firmwareVersion: "1245",
      fnFfdVersion: "1.0",
      model: 69,
      modelName: "АТОЛ 77Ф",
      receiptLineLength: 48,
      receiptLineLengthPix: 576,
      serial: "9232278066186"
    }
    assert _schema = pattern
  end
end