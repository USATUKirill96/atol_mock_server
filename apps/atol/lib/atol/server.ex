defmodule Atol.Server do
  use GenServer

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end


  # Server

  def handle_cast({:getShiftStatus, uuid}, state) do
    Atol.Shift.get_status(uuid)
    {:noreply, state}
  end

  def handle_cast({:getFnInfo, uuid}, state) do
    Atol.FiscalStorage.get_info(uuid)
    {:noreply, state}
  end

  def handle_cast({:getDeviceInfo, uuid}, state) do
    Atol.Device.get_info(uuid)
    {:noreply, state}
  end

  def handle_cast({:getDeviceParameters, {uuid, keys}}, state) do
    Atol.Device.get_parameters(uuid, keys)
    {:noreply, state}
  end

  def handle_cast({:setDeviceParameters, {uuid, parameters}}, state) do
    Atol.Device.set_parameters(uuid, parameters)
    {:noreply, state}
  end

  def handle_cast({:sell, uuid}, state) do
    Atol.Check.sell(uuid)
    {:noreply, state}
  end

  def handle_cast({:sellReturn, uuid}, state) do
    Atol.Check.sell_return(uuid)
    {:noreply, state}
  end

  def handle_cast({:continuePrint, uuid}, state) do
    Atol.Check.continue_print(uuid)
    {:noreply, state}
  end

  def handle_cast({:reportX, uuid}, state) do
    Atol.Report.print_report_x(uuid)
    {:noreply, state}
  end

  def handle_cast({:openShift, {uuid, operator}}, state) do
    Atol.Shift.open(uuid, operator)
    {:noreply, state}
  end

  def handle_cast({:closeShift, uuid}, state) do
    Atol.Shift.close(uuid)
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

