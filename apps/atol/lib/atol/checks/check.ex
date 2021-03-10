defmodule Atol.Checks.Check do
  @moduledoc """
  Структура чека и функции её генерации
  """

  alias __MODULE__
  alias Atol.Checks.FiscalParams
  alias Atol.Shifts.Shift

  @type t :: %__MODULE__{
          fiscal_params: FiscalParams.t(),
          warnings: list
        }
  defstruct fiscal_params: %FiscalParams{},
            warnings: nil

  use ExConstructor

  @doc """
  Получить информацию о чеке прихода
  """
  @spec sell(Shift.t()) :: Check.t()
  def sell(shift) do
    fiscal_params = FiscalParams.get(shift)
    Check.new(fiscal_params: fiscal_params)
  end

  @doc """
  Получить информацию о чеке возврата
  """
  @spec sell_return(Shift.t()) :: Check.t()
  # Ответ на печать чека прихода не отличается от чека возврата. При текущем функционале можно делегировать задачу
  def sell_return(shift) do
    sell(shift)
  end
end
