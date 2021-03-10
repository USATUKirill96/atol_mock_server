defmodule Dashboard.Action do
  alias __MODULE__
  alias EventBus.Model.Event

  @type t :: %__MODULE__{
          time: Time.t(),
          type: atom,
          text: String.t()
        }

  defstruct time: nil,
            type: nil,
            text: nil

  use ExConstructor

  @spec from_event(Event.t()) :: Action.t()
  def from_event(%{data: data, topic: topic} = event) do
    {:ok, datetime} = DateTime.now("Asia/Yekaterinburg")
    {:ok, text} = Jason.encode(data)

    %{
      time: datetime |> DateTime.to_time(),
      type: topic,
      text: text
    }
    |> Action.new()
  end

  @spec from_storage(list({Time.t(), Action.t()})) :: list(Action.t())
  def from_storage(storage_data) do
    list = for {_time, data} <- storage_data, do: data
    Enum.reverse(list)
  end
end
