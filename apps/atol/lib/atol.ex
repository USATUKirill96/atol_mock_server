defmodule Atol do
  @moduledoc false
  alias Atol.{Storage, Devices, Shifts, FiscalStorages}

  # Shift API

  @spec get_shift() :: Shifts.Shift.t()
  def get_shift() do
    Storage.get(:shift)
    |>Shifts.Shift.get()
  end

  @spec update_shift(map) :: :ok
  def update_shift(data) do
    data
    |>Shifts.Shift.get()
    |>Storage.update(:shift)
  end

  # Device API

  @spec get_device() :: Devices.Device.t()
  def get_device() do
    Storage.get(:device)
    |>Devices.Device.get()
  end

  @spec update_device(map) :: :ok
  def update_device(data) do
    data
    |>Devices.Device.get()
    |>Storage.update(:device)
  end

  # Fiscal Storage API

  @spec get_fiscal_storage() :: FiscalStorages.FiscalStorage.t()
  def get_fiscal_storage() do
    Storage.get(:fiscal_storage)
    |>FiscalStorages.FiscalStorage.get()
  end

  @spec update_fiscal_storage(map) :: :ok
  def update_fiscal_storage(data) do
    data
    |>FiscalStorages.FiscalStorage.get()
    |>Storage.update(:fiscal_storage)
  end
end
