defmodule Atol.Devices do
  alias Atol.Devices.Server

  def get_info(uuid) do
    Server.cast({:getInfo, uuid})
  end

  def get_parameters(uuid, keys) do
    Server.cast({:getParameters, {uuid, keys}})
  end

  def set_parameters(uuid, parameters) do
    Server.cast({:setParameters, {uuid, parameters}})
  end

  def get() do
    Server.call({:get})
  end

  def update(state) do
    Server.cast({:update, state})
  end

  def update(key, value) do
    Server.cast({:update, {key, value}})
  end
end
