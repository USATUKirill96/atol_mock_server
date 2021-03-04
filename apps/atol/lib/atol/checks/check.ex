defmodule Atol.Checks.Check do

  alias Atol.Checks.{Check, FiscalParams}
  alias Atol.Tasks

  defstruct fiscalParams: %FiscalParams{}, warnings: nil
  use ExConstructor


  @spec sell() :: :ok
  @doc """
  Создание задачи печати чека прихода
  """
  def sell() do
    {:ok, current_time} = DateTime.now("Asia/Yekaterinburg")
    current_time_iso = DateTime.to_iso8601(current_time)

    fiscal_params = %{
      fiscalDocumentDateTime: current_time_iso,
      registrationNumber: "0000000001002292",  # TODO: Взять из настроек
      shiftNumber:  Atol.Shifts.get().number,
      total: 500  # TODO: Считать из чека
    }
    |> FiscalParams.new()

    Check.new(fiscalParams: fiscal_params)
  end

  # Ответ на печать чека прихода не отличается от чека возврата. При текущем функционале можно делегировать задачу
  @spec sell_return() :: :ok
  def sell_return() do
    sell()
  end

  # Команда "продолжить печать" не ожидает получить какой-то конкретный ответ и проверяет только 200 статус
  @spec continue_print() :: :ok
  def continue_print() do
    "it's fine"
  end
end