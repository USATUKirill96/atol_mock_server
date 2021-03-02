defmodule Settings.Device do
  defstruct [serial: "00106900000014"]

  alias Settings.{Device, Storage}
  require Logger
  use Agent

  @key :device

  def start_link(_) do
    storage_data = Storage.call({:get, @key})
    case storage_data do
      {:ok, data} ->
        device_settings_struct = Kernel.struct(%Device{}, data)
        Agent.start_link(fn -> device_settings_struct end, name: __MODULE__)
      {:error, reason} ->
        Logger.info(reason)
        Agent.start_link(fn -> %Device{} end, name: __MODULE__)
    end
  end


  def get() do
    Agent.get(__MODULE__, &(&1))
  end

  def update(device_Settings) do
    Agent.update(__MODULE__, fn (_) -> device_Settings end)
    Storage.cast({:update, @key, device_Settings})
  end

end
