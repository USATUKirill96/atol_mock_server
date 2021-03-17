defmodule ShiftTest do
  alias Atol.Shifts.{Schema, Shift, Status}
  use ExUnit.Case


  test "get_shift" do
    shift = %{operator: "operator", number: 24, state: "opened"} |> Shift.get()
    assert shift.operator == "operator"
    assert shift.number == 24
    assert shift.state == "opened"
    assert %Shift{} = shift
  end

  test "open_shift" do
    shift = Shift.open("Test operator")
    assert shift.state == "opened"
    assert shift.operator == "Test operator"
    assert %Shift{} = shift
  end

  test "close_shift" do
    opened_shift = Shift.open("Test operator")
    closed_shift = Shift.close(opened_shift)

    assert opened_shift.number == closed_shift.number
    assert opened_shift.operator == closed_shift.operator
    assert closed_shift.state == "closed"
    assert %Shift{} = closed_shift
  end

  test "get_status" do
    _status = Shift.open("Test operator") |> Status.from_shift()
    pattern = %{
      expired_time: "some string",
      number: 1,
      state: "some string"
    }
    assert _status = pattern
  end

  test "schema_from_shift" do
    _schema = Shift.open("Test operator") |> Schema.from_shift()

    pattern = %{
      "fiscalParams" => %{
        "fiscalDocumentDateTime" => "2020-07-25T13:16:00+03:00",
        "fiscalDocumentNumber" => 123,
        "fiscalDocumentSign" => 123,
        "fnNumber" => "9999078900000961",
        "registrationNumber" => "0000000001002292",
        "shiftNumber" => 321,
        "fnsUrl" => "www.nalog.ru"
      },
      "warnings" => []
    }
    assert _schema = pattern
  end

  test "schema_from_status" do
    _schema = Shift.open("Test operator") |> Status.from_shift() |> Schema.from_status()

    pattern = %{
      "shiftStatus" => %{
        "expiredTime" => "some string",
        "number" => 123,
        "state" => "some state"
      }
    }
    assert _schema = pattern
  end
end