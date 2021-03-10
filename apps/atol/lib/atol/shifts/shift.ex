defmodule Atol.Shifts.Shift do
  alias __MODULE__
  require Logger
  alias Atol.Storage

  defstruct operator: "John Doel",
            number: 1,
            state: "closed"

  @type t :: %__MODULE__{
          operator: String.t(),
          number: integer,
          state: String.t()
        }

  use ExConstructor

  @spec get() :: Shift.t()
  def get() do
    Storage.get(:shift)
    |> Shift.new()
  end

  @spec update(map) :: map
  def update(data) do
    data
    |> Shift.new()
    |> Storage.update(:shift)

    data
  end

  @spec open(String.t()) :: Shift.t()
  def open(operator) do
    Shift.new(%{
      operator: operator,
      number: :rand.uniform(10_000_000),
      state: "opened"
    })
  end

  @spec close(Shift.t()) :: Shift.t()
  def close(shift) do
    shift
    |> Shift.new()
    |> Map.put(:state, "closed")
  end
end
