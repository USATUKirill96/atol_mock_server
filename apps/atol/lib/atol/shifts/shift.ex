defmodule Atol.Shifts.Shift do
  @moduledoc """
  Структура смены и логика работы с ней
  """

  alias __MODULE__
  require Logger
  alias Atol.Storage

  defstruct operator: "John Doe",
            number: 1,
            state: "closed"

  @type t :: %__MODULE__{
          operator: String.t(),
          number: integer,
          state: String.t()
        }

  use ExConstructor

  @spec get(map) :: Shift.t()
  def get(data) do
    data
    |> Shift.new()
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
