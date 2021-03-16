defmodule ChecksTest do
  alias Atol.Checks.{Check, Schema, FiscalParams}
  use ExUnit.Case

  test "sell" do
    _check =
      %Atol.Shifts.Shift{}
      |> Check.sell()

    expected_result = %Check{
      fiscal_params: %FiscalParams{},
      warnings: nil
    }

    assert _check = expected_result
  end

  test "sell_return" do
    _check =
      %Atol.Shifts.Shift{}
      |> Check.sell_return()

    expected_result = %Check{
      fiscal_params: %FiscalParams{},
      warnings: nil
    }

    assert _check = expected_result
  end

  test "schema_from_check" do
    _schema =
      %Atol.Shifts.Shift{}
      |> Check.sell()
      |> Schema.from_check()

    expected_result = %{
      "warnings" => [],
      "fiscal_params" => %{}
    }

    assert _schema = expected_result
  end

  test "schema_continue_print" do
    _schema = Schema.continue_print()

    expected_result = %{result: "ok"}

    assert _schema = expected_result
  end
end
