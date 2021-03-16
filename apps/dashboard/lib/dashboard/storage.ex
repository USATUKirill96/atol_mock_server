defmodule Dashboard.Storage do
  @moduledoc false

  alias Dashboard.Action
  use GenServer

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    :ets.new(__MODULE__, [:ordered_set, :named_table])
    {:ok, []}
  end

  # Server
  def handle_call(:get, _from, state) do
    data = :ets.tab2list(__MODULE__)
    {:reply, data, state}
  end

  def handle_cast({:add, data}, state) do
    :ets.insert_new(__MODULE__, {data.time, data})
    {:noreply, state}
  end

  def handle_cast(:clean, state) do
    :ets.delete_all_objects(__MODULE__)
    {:noreply, state}
  end

  # Client
  def call(args) do
    GenServer.call(__MODULE__, args)
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end

  # API
  @spec get() :: list({Time.t(), Action.t()})
  def get() do
    call(:get)
  end

  @spec add(Action.t()) :: :ok
  def add(data) do
    cast({:add, data})
  end

  @spec clean() :: :ok
  def clean() do
    cast(:clean)
  end
end
