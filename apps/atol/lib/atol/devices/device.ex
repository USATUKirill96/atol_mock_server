defmodule Atol.Devices.Device do
  @moduledoc """
  Структура устройства и логика работы с ней
  """

  alias __MODULE__
  alias Atol.Storage

  @type t :: %__MODULE__{
          serial: String.t(),
          parameters: map
        }

  defstruct serial: "9232278066186",
            parameters: %{}

  use ExConstructor

  @doc """
  Получить из хранилища информацию об устройстве
  """
  @spec get() :: Device.t()
  def get() do
    Storage.get(:device)
    |> Device.new()
  end

  @doc """
    Обновить информацию об устройстве в хранилище
  """
  @spec update(map) :: map
  def update(state) do
    state
    |> Device.new()
    |> Storage.update(:device)

    state
  end

  @doc """
  Обновить конкретное поле информации об устройстве в хранилище
  """
  @spec update(any, atom) :: any
  def update(value, field) do
    %{Storage.get(:device) | field => value}
    |> Device.new()
    |> Storage.update(:device)

    value
  end
end
