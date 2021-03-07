defmodule Atol.Storage do

  alias Atol.Storage.Server

  # API для обращения к хранилищу данных
  def get(key) do
    Server.call({:get, key})
  end

  def update(struct, key) do
    Server.cast({:update, key, struct})
  end
end