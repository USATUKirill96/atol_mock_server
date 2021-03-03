defmodule Settings.FiscalStorage do
  defstruct [
    number_of_registrations: 1,
    registrations_remaining: 29,
    serial: "9999078900008855",
    live_phase: "fiscalMode"
  ]

  alias Settings.{FiscalStorage, Storage}
  require Logger
  use Agent
  use ExConstructor


  @key :fiscal_storage

  def start_link(_) do
    storage_data = Storage.call({:get, @key})
    case storage_data do
      {:ok, data} ->
        fiscal_storage_Settings_settings_struct = FiscalStorage.new(data)
        Agent.start_link(fn -> fiscal_storage_Settings_settings_struct end, name: __MODULE__)
      {:error, reason} ->
        Logger.info(reason)
        Agent.start_link(fn -> %FiscalStorage{} end, name: __MODULE__)
    end
  end


  def get() do
    Agent.get(__MODULE__, &(&1))
  end

  def update(fiscal_storage_Settings) do
    Agent.update(__MODULE__, fn (_) -> fiscal_storage_Settings end)
    Storage.cast({:update, @key, fiscal_storage_Settings})
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