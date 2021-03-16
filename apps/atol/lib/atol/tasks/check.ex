defmodule Atol.Tasks.Check do
  alias Atol.{Checks, Shifts, Storage}
  alias Atol.Tasks.Queue
  use GenServer

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server

  def handle_cast({:sell, uuid}, state) do
    Storage.get(:shift)
    |> Shifts.Shift.get()
    |> Checks.Check.sell()
    |> Checks.Schema.from_check()
    |> Queue.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:return, uuid}, state) do
    Storage.get(:shift)
    |> Shifts.Shift.get()
    |> Checks.Check.sell_return()
    |> Checks.Schema.from_check()
    |> Queue.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:continue, uuid}, state) do
    Checks.Schema.continue_print()
    |> Queue.add(uuid)

    {:noreply, state}
  end

  # Client

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end
end
