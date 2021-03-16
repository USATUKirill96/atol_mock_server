defmodule Atol.FiscalStorages.LivePhases do
  def get() do
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