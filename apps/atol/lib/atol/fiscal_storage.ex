defmodule Atol.FiscalStorage do

  def get_info(uuid) do

    #TODO: Костыль, чтобы срок действия был позже текущего значения. Раздуплить даты, поправить
    next_year = Date.utc_today().year + 1
    parameters = Settings.FiscalStorage.get()

    %{
    "fnInfo" => %{
      "ffdVersion" => "1.05",
      "fnFfdVersion" => "1.0",
      "numberOfRegistrations" => parameters.number_of_registrations,
      "registrationsRemaining" => parameters.registrations_remaining,
      "serial" => parameters.serial,
      "validityDate" => "#{next_year}-04-15T21:00:00+03:00",
      "livePhase" => parameters.live_phase,
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