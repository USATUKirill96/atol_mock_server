defmodule Atol.FiscalStorages do
  alias Atol.FiscalStorages.Server

  def get_info(uuid) do
    Server.cast({:getFnInfo, uuid})
  end

  def get() do
    Server.call({:get})
  end

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
