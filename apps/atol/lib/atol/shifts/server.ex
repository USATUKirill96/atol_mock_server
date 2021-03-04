defmodule Atol.Shifts.Server do
  use GenServer
  alias Atol.Shifts.Shift
  alias Atol.Tasks


  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server

  def handle_cast({:getShiftStatus, uuid}, state) do
    Shift.get_status()
    |> Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:openShift, {uuid, operator}}, state) do
    Shift.open(operator)
    |> Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:closeShift, uuid}, state) do
    Shift.close()
    |> Tasks.add(uuid)

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
