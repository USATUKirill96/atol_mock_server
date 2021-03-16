defmodule Atol.Tasks.Reports do
  alias Atol.Tasks.Queue

  use GenServer

  # Service functions
  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, []}
  end

  def handle_cast({:print_report_x, uuid}, state) do
    Queue.add(%{"status" => "ok"}, uuid)

    {:noreply, state}
  end

  def cast(args) do
    GenServer.cast(__MODULE__, args)
  end
end
