defmodule Atol.Shifts.Shift do
  alias __MODULE__
  require Logger
  alias Atol.Storage

  defstruct operator: "John Doel",
            number: 1,
            state: "closed"
  use ExConstructor

  def get() do
    Storage.get(:shift)
    |>Shift.new()
  end

  def update(data) do
    data
    |>Shift.new()
    |>Storage.update(:shift)

    data
  end


  def open(operator) do
    Shift.new(
      %{
        operator: operator,
        number: :rand.uniform(10_000_000),
        state: "opened"
      }
    )
  end

  def close(shift) do
    shift
    |>Shift.new()
    |>Map.put(:state, "closed")
  end
end
