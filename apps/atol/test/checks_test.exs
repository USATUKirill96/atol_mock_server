defmodule ChecksTest do
  use ExUnit.Case

  setup do
    children = [
      Atol.Checks.Server,
      Atol.Shifts.Server,
      Atol.Tasks
    ]

    start_supervised(children)
    :ok
  end

  test "check_sell" do

    uuid = UUID.uuid4()

    Atol.Checks.sell(uuid)

    result = Atol.Tasks.pop(uuid)

    :timer.sleep(1000)

    assert result != nil
  end
end