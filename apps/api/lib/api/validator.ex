defmodule Api.Validator do
  def validate(params) do
    params
    |> get_schema()
    |> case do
      :error -> {:error, ["Для запроса #{params} не найдена схема валидации"]}
      schema -> Skooma.valid?(params, schema)
    end
  end

  def get_schema(%{"request" => %{"type" => "getShiftStatus"}}) do
    %{"request" => %{"type" => :string}, "uuid" => :string}
  end

  def get_schema(%{"request" => %{"type" => "getFnInfo"}}) do
    %{"request" => %{"type" => :string}, "uuid" => :string}
  end

  def get_schema(%{"request" => %{"type" => "getDeviceInfo"}}) do
    %{"request" => %{"type" => :string}, "uuid" => :string}
  end

  def get_schema(%{"request" => %{"type" => "getDeviceParameters"}}) do
    %{"request" => %{"type" => :string, "keys" => [:list, :int]}, "uuid" => :string}
  end

  def get_schema(%{"request" => %{"type" => "setDeviceParameters"}} = params) do
    IO.inspect(params, label: "Что в параметрах для схемы")
    %{
      "request" => %{"deviceParameters" => [:list, :map, &device_parameters/0], "type" => :string},
      "uuid" => :string
    }
  end

  def get_schema(%{"request" => %{"type" => "sell"}}) do

    %{
      "request" => %{
      "items" => [:list, :map, &item_schema/0],
      "operator" => %{"name" => :string, "vatin" => :string},
      "payments" => [:list, :map, &payment_schema/0],
      "preItems" => [:list, :map, :not_required, &pre_item_schema/0],
      "taxationType" => :string,
      "type" => :string,
      "ignoreNonFiscalPrintErrors" => [:bool, :not_required]
      },
      "uuid" => :string
    }
  end

  def get_schema(%{"request" => %{"type" => "sellReturn"}}) do
    get_schema(%{"request" => %{"type" => "sell"}})
  end

  def get_schema(%{"request" => %{"type" => "continuePrint"}}) do
    %{"request" => %{"type" => :string}, "uuid" => :string}
  end

  def get_schema(%{"request" => %{"type" => "reportX"}}) do
    %{
      "request" => %{"operator" => %{"name" => :string, "vatin" => :string}, "type" => :string},
      "uuid" => :string
    }
  end

  def get_schema(%{"request" => %{"type" => "openShift"}}) do
    %{
      "request" => %{"operator" => %{"name" => :string, "vatin" => :string}, "type" => :string},
      "uuid" => :string
    }
  end

  def get_schema(%{"request" => %{"type" => "closeShift"}}) do
    %{
      "request" => %{"operator" => %{"name" => :string, "vatin" => :string}, "type" => :string},
      "uuid" => :string
    }
  end

  def get_schema(_) do
    :error
  end

  defp device_parameters do %{"key" => :int, "value" => :string} end

  defp item_schema do
    %{
      "amount" => :int,
      "id" => [:int, :not_required],
      "name" => :string,
      "price" => :int,
      "quantity" => :int,
      "tax" => %{"type" => :string},
      "type" => :string
    }
  end

  defp payment_schema do
    %{
      "sum" => :int,
      "type" => :string
    }
  end

  defp pre_item_schema do
    %{"doubleHeight" => :bool, "doubleWidth" => :bool, "text" => :string, "type" => :string}
  end

end
