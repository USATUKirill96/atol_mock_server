defmodule Dashboard do

  def get do
    Dashboard.Storage.get()
    |>Dashboard.Action.from_storage()
  end
end
