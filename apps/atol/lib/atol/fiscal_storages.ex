defmodule Atol.FiscalStorages do
  alias Atol.FiscalStorages.{Server, FiscalStorage}

  @spec get_info(integer) :: :ok
  def get_info(uuid) do
    Server.cast({:getFnInfo, uuid})
  end

  @spec get() :: FiscalStorage.t()
  def get() do
    Server.call({:get})
  end

  @spec update(map) :: :ok
  def update(state) do
    Server.cast({:update, state})
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
