defmodule Dashboard do
  alias Dashboard.Action

  @spec get() :: list(Action.t() | nil)
  def get do
    Dashboard.Storage.get()
    |> Dashboard.Action.from_storage()
  end
end
