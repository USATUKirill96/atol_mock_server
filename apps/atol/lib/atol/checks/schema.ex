defmodule Atol.Checks.Schema do
  @moduledoc """
  Преобразование информации о чеке в схему для предоставления в API
  """

  alias __MODULE__
  alias Atol.Checks.Check

  @doc """
  Преобразовать информацию о чеке в JSON-сериализуемую структуру для передачи в API клиенту
  """
  @spec from_check(Check.t()) :: map
  def from_check(check) do
    fiscal_params =
      check.fiscal_params
      |> Map.from_struct()
      |> Recase.Enumerable.convert_keys(&Recase.to_camel/1)

    %{
      "fiscalParams" => fiscal_params,
      "warnings" => []
    }
  end

  @spec continue_print() :: map
  def continue_print() do
    # Команда "продолжить печать" не ожидает получить какой-то конкретный ответ и проверяет только 200 статус
    %{result: "ok"}
  end
end
