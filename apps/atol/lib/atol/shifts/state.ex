defmodule Atol.Shifts.State do

  require Logger
  use GenServer
  use Atol.Utils.Storage


  @storage :shifts

  defp fixtures() do
    [
    %{operator: "John Doel",
      number: 1,
      state: "closed"}
    ]
  end

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    # Инициализировать таблицу в памяти и открыть хранилище на диске
    storage_init(@storage)

    try do
      # Выгрузить данные из хранилища в память
      storage_load([:shift], @storage)
    rescue
      # Если данных в памяти нет, выгрузить фикстуры и повторить попытку
      e in ArgumentError -> Logger.warn("Ошибка загрузки данных с диска. Загружаю дефолтные значения")
                            load_fixtures(fixtures, @storage)
                            init([])
    end
    {:ok, []}
  end

  def handle_call({:get, key}, _from, state) do
    data = storage_get(key, @storage)
    {:reply, data, state}
  end

  def handle_cast({:update, key, struct}, state) do
    key
    |>storage_update(struct, @storage)
    {:noreply, state}
  end

  # Client
  def call(args) do
    GenServer.call(__MODULE__, args)
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end

  def get(key) do
      call({:get, key})
  end

  def update(struct, key) do
    cast({:update, key, struct})
  end

end