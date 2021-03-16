defmodule Atol.Checks.FiscalParams do
  @moduledoc """
  Структура фискальных параметров чека и функция её генерации
  """

  alias __MODULE__
  alias Atol.Shifts.Shift

  @type t :: %__MODULE__{
          fiscal_document_datetime: DateTime.t(),
          fiscal_document_sign: integer,
          fiscal_document_sign: String.t(),
          fiscal_receipt_number: integer,
          fn_number: String.t(),
          registration_number: String.t(),
          shift_number: integer,
          total: integer,
          fnsUrl: String.t()
        }

  defstruct fiscal_document_datetime: nil,
            fiscal_document_number: 1234,
            fiscal_document_sign: "1234",
            fiscal_receipt_number: 1234,
            # TODO: Добавить в настройки
            fn_number: "7043675145990",
            # TODO: Добавить в настройки
            registration_number: "6735973067197",
            shift_number: 1234,
            total: 500,
            fnsUrl: "www.nalog.ru"

  use ExConstructor

  @doc """
  Сформировать структуру фискальных параметров чека, основываясь на информации о смене
  """
  @spec get(Shift.t()) :: FiscalParams.t()
  def get(shift) do
    {:ok, current_time} = DateTime.now("Asia/Yekaterinburg")
    current_time_iso = DateTime.to_iso8601(current_time)

    %{
      fiscal_document_number: :rand.uniform(10_000_000),
      fiscal_document_sign: :rand.uniform(10_000_000) |> Integer.to_string(),
      fiscal_receipt_number: :rand.uniform(10_000_000),
      fiscalDocument_date_time: current_time_iso,
      # TODO: Взять из настроек
      registration_number: "0000000001002292",
      shift_number: shift.number,
      # TODO: Считать из чека
      total: 500
    }
    |> FiscalParams.new()
  end
end
