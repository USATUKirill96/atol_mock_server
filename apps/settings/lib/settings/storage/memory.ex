defmodule Settings.Storage.Memory do
  use Agent

  alias Settings.Storage.Disk

  def start_link(_) do
    Agent.start_link(fn -> Disk.call({:get}) end, name: __MODULE__)
  end

  def get() do
    Agent.get(__MODULE__, &(&1))
  end

  def update(new_state) do
    Agent.update(__MODULE__, fn (_) -> new_state end)
  end

end
