defmodule Atol.Checks.Server do
  use GenServer
  alias Atol.Checks.{Check, Schema}
  alias Atol.Shifts.Shift

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server
  def handle_cast({:sell, uuid}, state) do
    Shift.get()
    |> Check.sell()
    |> Schema.from_check()
    |> Atol.Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:sellReturn, uuid}, state) do
    Shift.get()
    |> Check.sell_return()
    |> Schema.from_check()
    |> Atol.Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:continuePrint, uuid}, state) do
    Schema.continue_print()
    |> Atol.Tasks.add(uuid)

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
