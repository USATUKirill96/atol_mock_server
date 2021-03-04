defmodule Atol.Checks.Check do

  alias Atol.Checks.{Check, FiscalParams}
  alias Atol.Tasks

  defstruct fiscalParams: %FiscalParams{},
            warnings: nil

  use ExConstructor


  @spec sell() :: :ok
  @doc """
  Создание задачи печати чека прихода
  """
  def sell() do
    fiscal_params = FiscalParams.get()
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