defmodule Settings.Storage.Disk do

  use GenServer

  # constants
  @storage :disk_storage
  @key "settings"

   # Service
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    :dets.open_file(@storage, [type: :set])
    # Если приложение запускается впервые, загрузить на диск дефолтные значения
    if (:dets.lookup(@storage, @key) == []) do
      initial_value = %Settings{}
                      |>Map.from_struct()
      :dets.insert_new(@storage, {@key, initial_value})
    end
    {:ok, []}
  end

  # Server
  def handle_call({:get}, _from, state) do
    [{@key, data}] = :dets.lookup(@storage, @key)
    settings = Kernel.struct(%Settings{}, data)
    {:reply, settings, state}
  end

  def handle_cast({:update, settings}, state) do
    # ETS не хранит структуры, нужно мапить их на ассоциативные массивы
    save_data = Map.from_struct(settings)
    :dets.delete(@storage, @key)
    :dets.insert_new(@storage, {@key, save_data})
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