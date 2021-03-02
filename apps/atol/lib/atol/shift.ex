defmodule Atol.Shift do

  def open(uuid, operator) do
    previous_shift_state = Settings.Shift.get()
    number = :rand.uniform(10000000)

    %{previous_shift_state| number: number, state: "opened", operator: operator}
    |>Settings.Shift.update()

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

    shift = Settings.Shift.get()

   %{shift| state: "closed"}
   |>Settings.Shift.update()

    %{
      "fiscalParams" => %{
        "fiscalDocumentDateTime" => "2020-07-25T13:12:00+03:00",
        "fiscalDocumentNumber" => :rand.uniform(10000000),
        "fiscalDocumentSign" => :rand.uniform(10000000),
        "fnNumber" => "9999078900000961",
        "registrationNumber" => "0000000001002292",
        "shiftNumber" => shift.number,
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

    %{:number => number, :state => state} = Settings.Shift.get()

    %{"shiftStatus" => %{"expiredTime" => "#{next_year}-03-06T13:52:59+03:00","number" => number,"state" => state}}
    |>Tasks.add(uuid)
  end

end

