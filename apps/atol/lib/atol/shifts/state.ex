defmodule Atol.Shifts.State do

  require Logger
  use GenServer
  use Atol.Utils.Storage


  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    # Инициализировать таблицу в памяти и открыть хранилище на диске
    storage_init()

    try do
      # Выгрузить данные из хранилища в память
      storage_load([:shift])
    rescue
      # Если данных в памяти нет, выгрузить фикстуры и повторить попытку
      e in ArgumentError -> Logger.warn("Ошибка загрузки данных с диска. Загружаю дефолтные значения")
                            load_fixtures(fixtures())
                            storage_load([:shift])
    end
    {:ok, []}
  end

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

  def get(key) do
      call({:get, key})
  end

  def update(struct, key) do
    cast({:update, key, struct})
  end

  defp fixtures() do
    [
      {:shift,
        %{
          operator: "John Doel",
          number: 1,
          state: "closed"
        }
      }
    ]
  end

end
