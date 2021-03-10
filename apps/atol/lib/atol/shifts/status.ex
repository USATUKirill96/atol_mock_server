defmodule Atol.Shifts.Status do
  alias __MODULE__
  alias Atol.Shifts.Shift

  @type t :: %__MODULE__{
          expired_time: String.t(),
          number: integer,
          state: String.t()
        }

  defstruct expired_time: "#2022-03-06T13:52:59+03:00",
            number: 1,
            state: "closed"

  use ExConstructor

  @spec from_shift(Shift.t()) :: Status.t()
  def from_shift(shift) do
    # TODO: Костыль, чтобы дата закрытия смены была позже текущего значения. Раздуплить даты, поправить
    next_year = Date.utc_today().year + 1

    %{number: shift.number, state: shift.state, expired_time: "#{next_year}-03-06T13:52:59+03:00"}
    |> Status.new()
  end
end
