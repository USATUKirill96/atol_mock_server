defmodule Atol.Devices.Device do
  alias Atol.Devices.State
  alias __MODULE__

  defstruct serial: "9232278066186",  # Заводской номер
            parameters: %{}

  use ExConstructor

  def get() do
    State.get(:device)
    |>Device.new()
  end

  def update(state) do
    state
    |>Device.new()
    |>State.update(:device)

    state
  end

  def update(value, field) do
    %{State.get(:device) | field => value}
    |>Device.new()
    |>State.update(:update)

    value
  end

end
