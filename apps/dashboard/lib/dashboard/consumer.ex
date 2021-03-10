defmodule Dashboard.Consumer do
  @moduledoc """
    entry-point для событий из шины данных.

    При запуске подписывается на события, которые нужно отразить в панели управления.
    При получении события форматирует его и сохраняет
  """

  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    EventBus.subscribe({Dashboard.Consumer, ["api_events", "errors"]})
    {:ok, []}
  end

  def process({_topic, _id} = event_shadow) do
    GenServer.cast(__MODULE__, event_shadow)
    :ok
  end

  def handle_cast({:api_events, id} = event_shadow, state) do
    EventBus.fetch_event({:api_events, id})
    |> Dashboard.Action.from_event()
    |> Dashboard.Storage.add()

    EventBus.mark_as_completed({__MODULE__, event_shadow})
    {:noreply, state}
  end

  def handle_cast({:errors, id} = event_shadow, state) do
    EventBus.fetch_event({:errors, id})
    |> Dashboard.Action.from_event()
    |> Dashboard.Storage.add()

    EventBus.mark_as_completed({__MODULE__, event_shadow})
    {:noreply, state}
  end

  def handle_cast({_topic, _id} = event_shadow, state) do
    EventBus.mark_as_skipped({__MODULE__, event_shadow})
    {:noreply, state}
  end
end
