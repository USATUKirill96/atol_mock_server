defmodule Atol.FiscalStorages.FiscalStorage do
  defstruct number_of_registrations: 1,
            registrations_remaining: 29,
            serial: "9999078900008855",
            live_phase: "fiscalMode"

  alias Atol.FiscalStorages.State
  require Logger
  use ExConstructor
  alias __MODULE__

  @key :fiscal_storage


  def get_info(uuid) do
    State.get(@key)
    |>FiscalStorage.new()
  end

  def update(fiscal_storage_Settings) do
    fiscal_storage_Settings
    |>State.update(@key)
  end

  def live_phases() do
    [
      {"Настройка ФН", "init"},
      {"Настроен, готов в активации", "configured"},
      {"Фискальный режим", "fiscalMode"},
      {"Постфискальный режим", "postFiscalMode"},
      {"Доступ к архиву ФН", "accessArchive"},
      {"Неизвестная фаза жизни", "unknown"}
    ]
  end
end
