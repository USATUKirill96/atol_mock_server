defmodule Atol.FiscalStorage do

  def get_info(uuid) do

    #TODO: Костыль, чтобы срок действия был позже текущего значения. Раздуплить даты, поправить
    next_year = Date.utc_today().year + 1

   %{
   "fnInfo" => %{
      "ffdVersion" => "1.05",
      "fnFfdVersion" => "1.0",
      "numberOfRegistrations" => 1,
      "registrationsRemaining" => 29,
      "serial" => "9999078900008855",
      "validityDate" => "#{next_year}-04-15T21:00:00+03:00",
      "livePhase" => "fiscalMode",
      "warnings" => %{
        "criticalError" => false,
        "memoryOverflow" => false,
        "needReplacement" => false,
        "ofdTimeout" => false,
        "resourceExhausted" => false
      }
    }
   }
    |>Tasks.add(uuid)
  end
end