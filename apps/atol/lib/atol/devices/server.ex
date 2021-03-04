defmodule Atol.Devices.Server do
  use GenServer
  alias Atol.Tasks

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server
  def handle_cast({:getDeviceInfo, uuid}, state) do
    Atol.Devices.Device.get_info()
    |> Tasks.add(uuid)
    {:noreply, state}
  end

  def handle_cast({:getDeviceParameters, {uuid, keys}}, state) do
    Atol.Devices.Parameters.get_parameters(keys)
    |> Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_cast({:setDeviceParameters, {uuid, parameters}}, state) do
    Atol.Devices.Parameters.set_parameters( parameters)
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
