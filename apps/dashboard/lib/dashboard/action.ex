defmodule Dashboard.Action do
  @moduledoc """
  Структура события панели управления и методы работы с ней
  """

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

  @doc """
  Создать событие из полученного ивента
  """
  @spec from_event(Event.t()) :: Action.t()
  def from_event(%{data: data, topic: topic}) do
    {:ok, datetime} = DateTime.now("Asia/Yekaterinburg")
    {:ok, text} = Jason.encode(data)

    %{
      time: datetime |> DateTime.to_time(),
      type: topic,
      text: text
    }
    |> Action.new()
  end

  @doc """
  Сформировать список событий из данных хранилища
  """
  @spec from_storage(list({Time.t(), Action.t()})) :: list(Action.t())
  def from_storage(storage_data) do
    list = for {_time, data} <- storage_data, do: data

    Enum.sort_by(list, fn action -> action.time end)
    |> Enum.reverse()
  end
end
