defmodule SettingsTest do
  use ExUnit.Case
  doctest Settings

  test "greets the world" do
    assert Settings.hello() == :world
  end
end
