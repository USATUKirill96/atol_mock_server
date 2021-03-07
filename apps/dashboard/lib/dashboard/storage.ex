defmodule Dashboard.Storage do
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

  # Client
  def call(args) do
    GenServer.call(__MODULE__, args)
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end

  # API
  def get() do
    call(:get)
  end

  def add(data) do
    cast({:add, data})
  end
end