defmodule Atol.FiscalStorages.Server do
  use GenServer
  alias Atol.FiscalStorages.{FiscalStorage, Schema}

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server
  def handle_cast({:getFnInfo, uuid}, state) do
    FiscalStorage.get()
    |> Schema.get_fn_info()
    |> Atol.Tasks.add(uuid)

    {:noreply, state}
  end

  def handle_call({:get}, _from, state) do
    data = FiscalStorage.get()
    {:reply, data, state}
  end

  def handle_cast({:update, data}, state) do
    FiscalStorage.update(data)
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
