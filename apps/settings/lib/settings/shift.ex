defmodule Settings.Shift do

  alias Settings.{Shift, Storage}
  require Logger
  use Agent

  defstruct [
    operator: "John Doel",
    number: 1,
    state: "closed"
  ]

  @key :shift

  def start_link(_) do
    storage_data = Storage.call({:get, @key})
    case storage_data do
      {:ok, data} ->
        shift_settings_struct = Kernel.struct(%Shift{}, data)
        Agent.start_link(fn -> shift_settings_struct end, name: __MODULE__)
      {:error, reason} ->
        Logger.info(reason)
        Agent.start_link(fn -> %Shift{} end, name: __MODULE__)
    end
  end


  def get() do
    Agent.get(__MODULE__, &(&1))
  end

  def update(shift_Settings) do
    Agent.update(__MODULE__, fn (_) -> shift_Settings end)
    Storage.cast({:update, @key, shift_Settings})
  end

end