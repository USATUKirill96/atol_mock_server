defmodule Atol.Checks.Schema do
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

  def continue_print() do
    # Команда "продолжить печать" не ожидает получить какой-то конкретный ответ и проверяет только 200 статус
    :ok
  end
end
