defmodule Atol.FiscalStorages.Server do
  use GenServer
  alias Atol.FiscalStorages.FiscalStorage

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server
  def handle_cast({:getFnInfo, uuid}, state) do
    FiscalStorage.get_info(uuid)
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
