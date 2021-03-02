defmodule Settings.Storage do
  @moduledoc """
  Реализует хранение данных в памяти устройства, чтобы сохранять настройки между перезагрузками сервера
  """
  use GenServer

  # constants
  @storage :disk_storage

   # Service
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    :dets.open_file(@storage, [type: :set])
    {:ok, []}
  end

  # Server
  def handle_call({:get, key}, _from, state) do
    ets_reply = :dets.lookup(@storage, key)
    case ets_reply do
      [{key, data}] -> {:reply, {:ok, data}, state}
      [] -> {:reply, {:error, "Информации по ключу нет на диске"}, state}
    end
  end

  def handle_cast({:update, key, data}, state) do
    # ETS не хранит структуры, нужно мапить их на ассоциативные массивы
    map_data = Map.from_struct(data)
    :dets.delete(@storage, key)
    :dets.insert_new(@storage, {key, map_data})
    {:noreply, state}
  end

  # Client
  def call(args) do
    GenServer.call(__MODULE__, args)
  end

  def cast(args) do
    GenServer.cast(__MODULE__,  args)
  end

end