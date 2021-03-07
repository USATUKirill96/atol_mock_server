defmodule Atol.Storage.Fixtures.Shift do
  def get() do
    {:shift,
     %{
       operator: "John Doe",
       number: 1,
       state: "closed"
     }}
  end
end
