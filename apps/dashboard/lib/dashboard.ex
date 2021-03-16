defmodule Dashboard do
  @moduledoc """
  API приложения Dashboard
  """

  alias Dashboard.Action

  @doc """
  Получить список событий с момента запуска севера
  """
  @spec get() :: list(Action.t() | nil)
  def get do
    Dashboard.Storage.get()
    |> Dashboard.Action.from_storage()
  end

  def clean do
    Dashboard.Storage.clean()
  end
end
