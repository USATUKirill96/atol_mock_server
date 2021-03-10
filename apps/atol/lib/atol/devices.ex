defmodule Atol.Devices do
  @moduledoc """
    Получение и обновление настроек устройства
  """
  alias Atol.Devices.{Server, Device}

  @spec get_info(integer) :: :ok
  def get_info(uuid) do
    Server.cast({:getInfo, uuid})
  end

  @spec get_parameters(integer, list(integer)) :: :ok
  def get_parameters(uuid, keys) do
    Server.cast({:getParameters, {uuid, keys}})
  end

  @spec set_parameters(integer, list(map)) :: :ok
  def set_parameters(uuid, parameters) do
    Server.cast({:setParameters, {uuid, parameters}})
  end

  @spec get() :: Device.t()
  def get() do
    Server.call({:get})
  end

  @spec update(map) :: :ok
  def update(state) do
    Server.cast({:update, state})
  end

  @spec update(any, atom) :: :ok
  def update(key, value) do
    Server.cast({:update, {key, value}})
  end
end
