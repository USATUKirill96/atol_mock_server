defmodule Dashboard.Action do
  alias __MODULE__

  defstruct time: nil,
            type: nil,
            text: nil

  use ExConstructor

  def from_event(%{data: data, topic: topic} = event) do
    {:ok, datetime} = DateTime.now("Asia/Yekaterinburg")
    {:ok, text} = Jason.encode(data)
    %{
      time: datetime |>DateTime.to_time(),
      type: topic,
      text: text
    }
    |>Action.new()
  end

  def from_storage(storage_data) do
    for {_time, data} <- storage_data, do: data
  end
end