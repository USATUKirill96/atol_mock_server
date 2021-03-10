defmodule Atol.Storage do
  @moduledoc """
  Получение и обновление данных хранилища

  ## Examples

      iex> Atol.Storage.update(:foo, "buzz")
      :ok

      iex> Atol.Storage.get(:foo)
      "buzz"
  """

  alias Atol.Storage.Server

  # API для обращения к хранилищу данных
  @spec get(atom) :: map
  def get(key) do
    Server.call({:get, key})
  end

  @spec update(map, atom) :: :ok
  def update(struct, key) do
    Server.cast({:update, key, struct})
  end
end
