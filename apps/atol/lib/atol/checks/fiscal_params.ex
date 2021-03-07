defmodule Atol.Checks.FiscalParams do
  alias __MODULE__

  #  @type t :: %Atol.Checks.FiscalParams{
  #                fiscalDocumentDateTime: Datetime.t(),
  #                fiscalDocumentNumber: integer,
  #                fiscalDocumentSign: String.t(),
  #                fiscalReceiptNumber: integer,
  #                fnNumber: String.t(),
  #                registrationNumber: String.t(),
  #                shiftNumber: integer,
  #                total: integer,
  #                fnsUrl: String.t()
  #             }

  defstruct fiscal_document_datetime: "2017-07-25T13:16:00+03:00",
            fiscal_document_number: :rand.uniform(10_000_000),
            fiscal_document_sign: :rand.uniform(10_000_000) |> Integer.to_string(),
            fiscal_receipt_number: :rand.uniform(10_000_000),
            # TODO: Добавить в настройки
            fn_number: "7043675145990",
            # TODO: Добавить в настройки
            registration_number: "6735973067197",
            shift_number: :rand.uniform(10_000_000),
            total: 500,
            fnsUrl: "www.nalog.ru"

  use ExConstructor

  def get(shift) do
    {:ok, current_time} = DateTime.now("Asia/Yekaterinburg")
    current_time_iso = DateTime.to_iso8601(current_time)

    %{
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
