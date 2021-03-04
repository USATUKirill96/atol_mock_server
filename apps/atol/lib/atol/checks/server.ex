defmodule Atol.Checks.Server do
  use GenServer
  alias Atol.Checks.Check
  alias Atol.Tasks

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server
  def handle_cast({:sell, uuid}, state) do
    Check.sell()
    |>Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:sellReturn, uuid}, state) do
    Check.sell_return()
    |>Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:continuePrint, uuid}, state) do
    Check.continue_print()
    |>Tasks.add(uuid)
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
