defmodule Atol.Checks do
  @moduledoc """
    Создание асинхронных задач, реализующих логику работы сервера с чеками

    ## Examples

      iex> Atol.Checks.sell(1)
      :ok

      iex> Atol.Checks.sell_return(2)
      :ok

      iex> Atol.Checks.sell(3)
      :ok
  """

  alias Atol.Checks.Server

  @spec sell(integer) :: :ok
  def sell(uuid) do
    Server.cast({:sell, uuid})
  end

  @spec sell_return(integer) :: :ok
  def sell_return(uuid) do
    Server.cast({:sellReturn, uuid})
  end

  @spec continue_print(integer) :: :ok
  def continue_print(uuid) do
    Server.cast({:continuePrint, uuid})
  end
end
