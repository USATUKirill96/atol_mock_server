defmodule Atol.Storage.Fixtures do

  alias Atol.Storage.Fixtures.{Device, FiscalStorage, Shift}

  @doc """
  Загрузить фикстуры на диск
  """
  def load_fixtures() do
    :dets.open_file(:disk_storage, type: :set)
    :dets.delete_all_objects(:disk_storage)

    fixtures()
    |>Enum.map(fn(data) -> :dets.insert_new(:disk_storage, data) end)
    :dets.close(:disk_storage)
  end

  def fixtures() do
    [
    Device.get(),
    FiscalStorage.get(),
    Shift.get()
    ]
  end
end