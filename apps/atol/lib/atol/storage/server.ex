defmodule Atol.Storage.Server do
  @moduledoc """
  Логика хранения данных приложения.

  Модуль реализует поведение сервера ОТП, который позволяет хранить и получать данные по ключу.
  Данные сохраняются на диск и кэшируются в памяти для быстрого доступа.
  """

  use GenServer


  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    # Инициализировать таблицу в памяти и открыть хранилище на диске
    storage_init()
    # Выгрузить данные из хранилища в память
    storage_load()
    {:ok, []}
  end


  # Server
  def handle_call({:get, key}, _from, state) do
    data = storage_get(key)
    {:reply, data, state}
  end

  def handle_cast({:update, key, struct}, state) do
    key
    |>storage_update(struct)
    {:noreply, state}
  end

  # Client
  def call(args) do
    GenServer.call(__MODULE__, args)
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end


  # Логика работы с Erlang Term Storage:

  @doc """
  Инициализировать хранилище.

  Открыть либо создать dets файл на диске с именем хранилища, а также создать в памяти ets таблицу
  """
  def storage_init() do
    :dets.open_file(:disk_storage, type: :set)
    :ets.new(__MODULE__, [:set, :public, :named_table])
  end


  @doc """
  Выгрузить данные с диска в память
  """
  def storage_load() do
    :dets.match(:disk_storage, :"$1")
    |>Enum.map(fn(data) -> :ets.insert_new(__MODULE__, data) end)
  end


  @doc """
  Получить данные из памяти
  """
  def storage_get(key) do
    [{_key, data}] = :ets.lookup(__MODULE__, key)
    data
  end


  @doc """
  Обновить данные в памяти и на диске
  """
  def storage_update(key, struct) do
    # ETS не хранит структуры, нужно мапить их на ассоциативные массивы
    data = Map.from_struct(struct)

    # Обновить в памяти
    :ets.delete(__MODULE__, key)
    :ets.insert_new(__MODULE__, {key, data})

    # Обновить на диске
    :dets.delete(:disk_storage, key)
    :dets.insert_new(:disk_storage, {key, data})

  end
end
