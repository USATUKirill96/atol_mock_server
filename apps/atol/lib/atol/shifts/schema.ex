defmodule Atol.Shifts.Schema do
  def from_shift(shift) do
    %{
      "fiscalParams" => %{
        "fiscalDocumentDateTime" => "2020-07-25T13:16:00+03:00",
        "fiscalDocumentNumber" => :rand.uniform(10_000_000),
        "fiscalDocumentSign" => :rand.uniform(10_000_000),
        "fnNumber" => "9999078900000961",
        "registrationNumber" => "0000000001002292",
        "shiftNumber" => shift.number,
        "fnsUrl" => "www.nalog.ru"
      },
      "warnings" => []
    }
  end

  def from_status(status) do
    %{
      "shiftStatus" => %{
        "expiredTime" => status.expired_time,
        "number" => status.number,
        "state" => status.state
      }
    }
  end
end
