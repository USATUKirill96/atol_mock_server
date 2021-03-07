defmodule Atol.Checks.Check do
  alias Atol.Checks.{Check, FiscalParams}

  defstruct fiscal_params: %FiscalParams{},
            warnings: nil

  use ExConstructor

  @doc """
  Создание задачи печати чека прихода
  """
  def sell(shift) do
    fiscal_params = FiscalParams.get(shift)
    Check.new(fiscal_params: fiscal_params)
  end

  # Ответ на печать чека прихода не отличается от чека возврата. При текущем функционале можно делегировать задачу
  def sell_return(shift) do
    sell(shift)
  end
end
