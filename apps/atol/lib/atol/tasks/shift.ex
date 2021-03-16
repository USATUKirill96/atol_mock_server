defmodule Atol.Tasks.Shift do
  @moduledoc false

  alias Atol.Storage
  alias Atol.Tasks.Queue
  alias Atol.Shifts.{Schema, Shift, Status}

  use GenServer

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  def handle_cast({:get_status, uuid}, state) do
    Storage.get(:shift)
    |> Shift.get()
    |> Status.from_shift()
    |> Schema.from_status()
    |> Queue.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:open, uuid, operator}, state) do
    shift =
      operator
      |> Shift.open()

    shift
    |> Storage.update(:shift)

    shift
    |> Schema.from_shift()
    |> Queue.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:close, uuid}, state) do
    shift =
      Storage.get(:shift)
      |> Shift.get()
      |> Shift.close()

    shift
    |> Storage.update(:shift)

    shift
    |> Schema.from_shift()
    |> Queue.add(uuid)

    {:noreply, state}
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end
end
