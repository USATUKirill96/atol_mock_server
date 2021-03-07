defmodule Atol.Shifts.Status do
  alias __MODULE__

  defstruct expired_time: "#2022-03-06T13:52:59+03:00",
            number: 1,
            state: "closed"

  use ExConstructor

  def from_shift(shift) do
    # TODO: Костыль, чтобы дата закрытия смены была позже текущего значения. Раздуплить даты, поправить
    next_year = Date.utc_today().year + 1

    %{number: shift.number, state: shift.state, expired_time: "#{next_year}-03-06T13:52:59+03:00"}
    |> Status.new()
  end
end
