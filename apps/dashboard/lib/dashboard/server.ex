defmodule Dashboard.Server do
  @moduledoc false
  

  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    EventBus.subscribe({Dashboard.Server, ["atol_messages", "api_messages"]})
    {:ok, []}
  end

  def process({topic, id} = event_shadow) do
    GenServer.cast(__MODULE__, event_shadow)
    :ok
  end


  def handle_cast({:api_messages, id} = event_shadow, state) do
    event = EventBus.fetch_event({:api_messages, id})
    IO.inspect(event, label: "Получил такие данные в подписчике")

    EventBus.mark_as_completed({__MODULE__, event_shadow})
    {:noreply, state}
  end

  def handle_cast({:atol_messages, id} = event_shadow, state) do
    event = EventBus.fetch_event({:atol_messages, id})
    IO.inspect(event, label: "Получил такие данные в подписчике")

    EventBus.mark_as_completed({__MODULE__, event_shadow})
    {:noreply, state}
  end

  def handle_cast({_topic, _id} = event_shadow, state) do
    IO.puts("Что-то получил")
    EventBus.mark_as_skipped({__MODULE__, event_shadow})
    {:noreply, state}

  end

end