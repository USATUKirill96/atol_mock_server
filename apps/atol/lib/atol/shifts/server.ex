defmodule Atol.Shifts.Server do
  @moduledoc false

  use GenServer
  alias Atol.Shifts.{Shift, Status, Schema}

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server

  def handle_cast({:getShiftStatus, uuid}, state) do
    Shift.get()
    |> Status.from_shift()
    |> Schema.from_status()
    |> Atol.Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:openShift, {uuid, operator}}, state) do
    Shift.open(operator)
    |> Shift.update()
    |> Schema.from_shift()
    |> Atol.Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:closeShift, uuid}, state) do
    Shift.get()
    |> Shift.close()
    |> Shift.update()
    |> Schema.from_shift()
    |> Atol.Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:update, data}, state) do
    data
    |> Shift.update()

    {:noreply, state}
  end

  # Client
  def call(args) do
    GenServer.call(__MODULE__, args)
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end
end
