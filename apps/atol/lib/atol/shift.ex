defmodule Atol.Shift do
 use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{number: 1, state: "closed", operator: "Прошлый оператор"} end, name: __MODULE__)
  end


  def get() do
    Agent.get(__MODULE__, &(&1))
  end


  def open(uuid, operator) do
    number = :rand.uniform(10000000)

    %{number: number, state: "opened", operator: operator}
    |>update_agent()

    %{
      "fiscalParams" => %{
        "fiscalDocumentDateTime" => "2020-07-25T13:16:00+03:00",
        "fiscalDocumentNumber" => :rand.uniform(10000000),
        "fiscalDocumentSign" => :rand.uniform(10000000),
        "fnNumber" => "9999078900000961",
        "registrationNumber" => "0000000001002292",
        "shiftNumber" => number,
        "fnsUrl" => "www.nalog.ru"
      },
      "warnings"=> %{
        "notPrinted"=> false
      }
    }
    |>Tasks.add(uuid)

  end


  def close(uuid) do
    shift = %{get() |state: "closed"}
    update_agent(shift)

    %{
      "fiscalParams" => %{
        "fiscalDocumentDateTime" => "2020-07-25T13:12:00+03:00",
        "fiscalDocumentNumber" => :rand.uniform(10000000),
        "fiscalDocumentSign" => :rand.uniform(10000000),
        "fnNumber" => "9999078900000961",
        "registrationNumber" => "0000000001002292",
        "shiftNumber" => shift[:number],
        "receiptsCount" => 23,
        "fnsUrl"=> "www.nalog.ru"
      },
      "warnings" => %{
        "notPrinted"=> false
      }
    }
    |>Tasks.add(uuid)
  end


  def get_status(uuid) do

    #TODO: Костыль, чтобы дата закрытия смены была позже текущего значения. Раздуплить даты, поправить
    next_year = Date.utc_today().year + 1

    %{:number => number, :state => state} = get()

    %{"shiftStatus" => %{"expiredTime" => "#{next_year}-03-06T13:52:59+03:00","number" => number,"state" => state}}
    |>Tasks.add(uuid)
  end

  defp update_agent(new_state) do
    Agent.update(__MODULE__, fn (_) -> new_state end)
  end
end

