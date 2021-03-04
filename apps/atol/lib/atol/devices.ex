defmodule Atol.Devices do
  alias Atol.Devices.Server

  def get_info(uuid) do
    Server.cast({:getDeviceInfo, uuid})
  end

  def get_parameters(uuid, keys) do
    Server.cast({:getDeviceParameters, {uuid, keys}})
  end

  def set_parameters(uuid, parameters) do
    Server.cast({:setDeviceParameters, {uuid, parameters}})
  end
end
