defmodule Atol.Devices.Device do
  alias Atol.Storage
  alias __MODULE__

  # Заводской номер
  defstruct serial: "9232278066186",
            parameters: %{}

  use ExConstructor

  def get() do
    Storage.get(:device)
    |> Device.new()
  end

  def update(state) do
    state
    |> Device.new()
    |> Storage.update(:device)

    state
  end

  def update(value, field) do
    %{Storage.get(:device) | field => value}
    |> Device.new()
    |> Storage.update(:device)

    value
  end
end
