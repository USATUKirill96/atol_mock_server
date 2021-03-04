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
      def storage_init(storage) do
        :dets.open_file(storage, type: :set)
        :ets.new(storage, [:set, :protected, :named_table])
      end


      @doc """
      Выгрузить данные с диска в память
      """
      def storage_load(keys, storage) do
        keys
        |>Enum.map(fn(key) -> :dets.lookup(storage, key) |> hd end)
        |>Enum.map(fn(data) -> :ets.insert_new(storage, data) end)
      end


      @doc """
      Получить данные из памяти
      """
      def storage_get(key, storage) do
        [{_key, data}] = :ets.lookup(storage, key)
        data
      end


      @doc """
      Обновить данные в памяти и на диске
      """
      def storage_update(key, struct, storage) do
        # ETS не хранит структуры, нужно мапить их на ассоциативные массивы
        data = Map.from_struct(struct)

        # Обновить в памяти
        :ets.delete(storage, key)
        :ets.insert_new(storage, {key, data})

        # Обновить на диске
        :dets.delete(storage, key)
        :dets.insert_new(storage, {key, data})

      end

      def load_fixtures(fixtures, storage) do
        fixtures
        |>Enum.map(fn({key, _}) -> :dets.delete(storage, key) end)

        fixtures
        |>Enum.map(fn(data) -> :dets.insert_new(storage, data) end)
    end
    end
  end
end