defmodule Atol.Storage.Fixtures.Device do
  @moduledoc false

  def get() do
    {:device,
     %{
       parameters: %{
         122 => "John Doe",
         150 => "7736207543"
       },
       serial: "9232278066186"
     }}
  end
end
