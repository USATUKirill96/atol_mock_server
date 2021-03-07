defmodule Atol.Devices.Server do
  use GenServer
  alias Atol.Devices.{Device, Parameters, Info, Schema}

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server
  def handle_cast({:getInfo, uuid}, state) do
    Device.get()
    |> Info.from_device()
    |> Schema.get_info()
    |> Atol.Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:getParameters, {uuid, keys}}, state) do
    Device.get()
    |> Schema.get_parameters(keys)
    |> Atol.Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:setParameters, {uuid, parameters}}, state) do
    Device.get()
    |> Parameters.update(parameters)
    |> Device.update(:parameters)
    |> Schema.set_parameters()
    |> Atol.Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_call({:get}, _from, state) do
    data = Device.get()
    {:reply, data, state}
  end

  def handle_cast({:update, data}, state) do
    Device.update(data)
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
