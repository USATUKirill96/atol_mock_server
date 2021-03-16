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
  @spec get(map) :: Device.t()
  def get(device_data) do
    device_data
    |> Device.new()
  end
end
