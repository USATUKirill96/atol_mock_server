defmodule Atol do

  def get_shift(uuid) do Atol.Server.cast({:getShiftStatus, uuid}) end
  def get_fn_info(uuid) do Atol.Server.cast({:getFnInfo, uuid}) end
  def get_device_info(uuid) do Atol.Server.cast({:getDeviceInfo, uuid}) end
  def get_device_parameters(uuid, keys) do Atol.Server.cast({:getDeviceParameters, {uuid, keys}}) end
  def set_device_parameters(uuid, parameters) do Atol.Server.cast({:setDeviceParameters, {uuid, parameters}}) end
  def sell(uuid) do Atol.Server.cast({:sell, uuid}) end
  def sell_return(uuid) do Atol.Server.cast({:sellReturn, uuid}) end
  def continue_print(uuid) do Atol.Server.cast({:continuePrint, uuid}) end
  def print_report_x(uuid) do Atol.Server.cast({:reportX, uuid}) end
  def open_shift(uuid, operator) do Atol.Server.cast({:openShift, {uuid, operator}}) end
  def close_shift(uuid) do Atol.Server.cast({:closeShift, uuid}) end
end
