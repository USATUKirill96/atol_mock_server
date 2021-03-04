defmodule Atol.Shifts.Shift do
  defstruct operator: "John Doel",
            number: 1,
            state: "closed"

  alias Atol.Shifts.State
  alias Atol.Tasks
  require Logger
  use ExConstructor


  def open(uuid, operator) do
    previous_shift_state = State.get(:shift)
    number = :rand.uniform(10_000_000)

    %{previous_shift_state | number: number, state: "opened", operator: operator}
    |> State.update(:shift)

    %{
      "fiscalParams" => %{
        "fiscalDocumentDateTime" => "2020-07-25T13:16:00+03:00",
        "fiscalDocumentNumber" => :rand.uniform(10_000_000),
        "fiscalDocumentSign" => :rand.uniform(10_000_000),
        "fnNumber" => "9999078900000961",
        "registrationNumber" => "0000000001002292",
        "shiftNumber" => number,
        "fnsUrl" => "www.nalog.ru"
      },
      "warnings" => %{
        "notPrinted" => false
      }
    }
    |> Tasks.add(uuid)
  end

  def close(uuid) do
    shift = State.get(:shift)

    %{shift | state: "closed"}
    |> State.update(:shift)

    %{
      "fiscalParams" => %{
        "fiscalDocumentDateTime" => "2020-07-25T13:12:00+03:00",
        "fiscalDocumentNumber" => :rand.uniform(10_000_000),
        "fiscalDocumentSign" => :rand.uniform(10_000_000),
        "fnNumber" => "9999078900000961",
        "registrationNumber" => "0000000001002292",
        "shiftNumber" => shift.number,
        "receiptsCount" => 23,
        "fnsUrl" => "www.nalog.ru"
      },
      "warnings" => %{
        "notPrinted" => false
      }
    }
    |> Tasks.add(uuid)
  end

  def get_status(uuid) do
    # TODO: Костыль, чтобы дата закрытия смены была позже текущего значения. Раздуплить даты, поправить
    next_year = Date.utc_today().year + 1

    %{:number => number, :state => state} = State.get(:shift)

    %{
      "shiftStatus" => %{
        "expiredTime" => "#{next_year}-03-06T13:52:59+03:00",
        "number" => number,
        "state" => state
      }
    }
    |> Tasks.add(uuid)
  end
end
