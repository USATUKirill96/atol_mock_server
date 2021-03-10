defmodule Atol.Reports.Server do
  @moduledoc false

  use GenServer

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  # Server

  def handle_cast({:printReportX, uuid}, state) do
    Atol.Tasks.add(%{result: "fine"}, uuid)
    {:noreply, state}
  end

  # Client
  def call(args) do
    GenServer.call(__MODULE__, args)
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end
end
