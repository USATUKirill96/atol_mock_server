defmodule DashboardTest do
  use ExUnit.Case
  doctest Dashboard

  test "greets the world" do
    assert Dashboard.hello() == :world
  end
end
