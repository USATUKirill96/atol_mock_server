defmodule Atol.Utils.Storage do
  @moduledoc """
  Реализует общую логику хранения данных приложения в ETS.

  Данные кэшируются в памяти, дублируясь на диск
  """

  defmacro __using__(_opts) do
    quote do

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
      def storage_load(keys) do
        keys
        |>Enum.map(fn(key) -> :dets.lookup(:disk_storage, key) |> hd end)
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

      def load_fixtures(fixtures) do
        fixtures
        |>Enum.map(fn({key, _}) -> :dets.delete(:disk_storage, key) end)

        fixtures
        |>Enum.map(fn(data) -> :dets.insert_new(:disk_storage, data) end)
    end
    end
  end
end