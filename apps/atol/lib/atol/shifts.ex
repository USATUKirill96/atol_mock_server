defmodule Atol.Shifts do
  alias Atol.Shifts.{State, Server, Shift}

  def get_status(uuid) do
    Server.cast({:getShiftStatus, uuid})
  end

  def open(uuid, operator) do
    Server.cast({:openShift, {uuid, operator}})
  end

  def close(uuid) do
    Server.cast({:closeShift, uuid})
  end

  def get() do
    State.get(:shift)
    |>Shift.new()
  end

  def update(state) do
    Server.cast({:update, state})
  end

end
