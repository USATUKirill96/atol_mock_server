defmodule Atol.Tasks.Device do
  alias Atol.Storage
  alias Atol.Tasks.Queue
  alias Atol.Devices.{Device, Schema, Parameters, Info}

  use GenServer

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  def handle_cast({:get_info, uuid}, state) do
    Storage.get(:device)
    |> Device.get()
    |> Info.from_device()
    |> Schema.get_info()
    |> Queue.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:get_parameters, uuid, keys}, state) do
    Storage.get(:device)
    |> Device.get()
    |> Schema.get_parameters(keys)
    |> Queue.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:set_parameters, uuid, parameters}, state) do
    parameters_struct =
      Storage.get(:device)
      |> Device.get()
      |> Parameters.update(parameters)

    Atol.get_device()
    |> Map.put(:parameters, parameters_struct)
    |> Storage.update(:device)

    parameters
    |> Schema.set_parameters()
    |> Queue.add(uuid)

    {:noreply, state}
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end
end
