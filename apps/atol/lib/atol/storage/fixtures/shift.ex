defmodule Atol.Storage.Fixtures.Shift do
  @moduledoc false

  def get() do
    {:shift,
     %{
       operator: "John Doe",
       number: 1,
       state: "closed"
     }}
  end
end
