defmodule Atol.Tasks do
  alias Atol.Tasks.{Check, Device, FiscalStorage, Queue, Reports, Shift}

  # Check API

  @spec sell_check(String.t()) :: :ok
  def sell_check(uuid) do
   Check.cast({:sell, uuid})
  end

  @spec sell_return_check(String.t()) :: :ok
  def sell_return_check(uuid) do
    Check.cast({:return, uuid})
  end

  @spec continue_print_check(String.t()) :: :ok
  def continue_print_check(uuid) do
    Check.cast({:continue, uuid})
  end

  # Device API

  @spec get_device_info(String.t()) :: :ok
  def get_device_info(uuid) do
    Device.cast({:get_info, uuid})
  end

  @spec get_device_parameters(String.t(), list(String.t())) :: :ok
  def get_device_parameters(uuid, keys) do
    Device.cast({:get_parameters, uuid, keys})
  end

  @spec set_device_parameters(String.t(), list(%{String.t() => String.t()})) :: :ok
  def set_device_parameters(uuid, parameters) do
    Device.cast({:set_parameters, uuid, parameters})
  end

  # Fiscal Storage API

  @spec get_fiscal_storage_info(String.t()) :: :ok
  def get_fiscal_storage_info(uuid) do
    FiscalStorage.cast({:get_info, uuid})
  end

  # Reports API

  @spec print_report_x(String.t()) :: :ok
  def print_report_x(uuid) do
    Reports.cast({:print_report_x, uuid})
  end

  # Shift API

  @spec get_shift_status(String.t()) :: :ok
  def get_shift_status(uuid) do
    Shift.cast({:get_status, uuid})
  end

  @spec open_shift(String.t(), String.t()) :: :ok
  def open_shift(uuid, operator) do
    Shift.cast({:open, uuid, operator})
  end

  @spec close_shift(String.t()) :: :ok
  def close_shift(uuid) do
    Shift.cast({:close, uuid})
  end

  # Queue API
  @spec pop(String.t()) :: any
  def pop(uuid) do
    Queue.pop(uuid)
  end
end
