defmodule Atol.Shifts.Shift do
  defstruct operator: "John Doel",
            number: 1,
            state: "closed"

  alias Atol.Shifts.{State, Shift}
  require Logger
  use ExConstructor

  def get() do
    State.get(:shift)
    |>Shift.new()
  end

  def update(data) do
    data
    |>Shift.new()
    |>State.update(:shift)

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
