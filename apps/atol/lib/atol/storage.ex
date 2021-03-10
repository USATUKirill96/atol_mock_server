defmodule Atol.Storage do
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
