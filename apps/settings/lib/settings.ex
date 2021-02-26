defmodule Settings do
  defstruct [cashier: "John Doel"]

  alias Settings.Storage.{Memory, Disk}

  def get() do
    Memory.get()
  end

  def update(settings) do
    Memory.update(settings)
    Disk.cast({:update, settings})
  end

end
