defmodule Atol.Tasks.FiscalStorage do
  @moduledoc false

  alias Atol.Storage
  alias Atol.Tasks.Queue
  alias Atol.FiscalStorages.{FiscalStorage, Schema}

  use GenServer

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  def handle_cast({:get_info, uuid}, state) do
    Storage.get(:fiscal_storage)
    |> FiscalStorage.get()
    |> Schema.get_fn_info()
    |> Queue.add(uuid)

    {:noreply, state}
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end
end
