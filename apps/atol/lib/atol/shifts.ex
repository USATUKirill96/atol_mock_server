defmodule Atol.Shifts do
  @moduledoc """
  Получение и обновление информации о смене, а также создание асинхронных задач выполнения логики работы сервера
  """

  alias Atol.Shifts.{Server, Shift}
  alias Atol.Storage

  @spec get_status(integer) :: :ok
  def get_status(uuid) do
    Server.cast({:getShiftStatus, uuid})
  end

  @spec open(integer, String.t()) :: :ok
  def open(uuid, operator) do
    Server.cast({:openShift, {uuid, operator}})
  end

  @spec close(integer) :: :ok
  def close(uuid) do
    Server.cast({:closeShift, uuid})
  end

  @spec get() :: Shift.t()
  def get() do
    Storage.get(:shift)
    |> Shift.new()
  end

  @spec update(map) :: :ok
  def update(state) do
    Server.cast({:update, state})
  end
end
