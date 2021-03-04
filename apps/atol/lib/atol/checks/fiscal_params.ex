defmodule Atol.Checks.FiscalParams do
  alias __MODULE__

  @type t :: %Atol.Checks.FiscalParams{
                fiscalDocumentDateTime: Datetime.t(),
                fiscalDocumentNumber: integer,
                fiscalDocumentSign: String.t(),
                fiscalReceiptNumber: integer,
                fnNumber: String.t(),
                registrationNumber: String.t(),
                shiftNumber: integer,
                total: integer,
                fnsUrl: String.t()
             }

  defstruct fiscalDocumentDateTime:  "2017-07-25T13:16:00+03:00",
            fiscalDocumentNumber: :rand.uniform(10_000_000),
            fiscalDocumentSign: :rand.uniform(10_000_000) |> Integer.to_string(),
            fiscalReceiptNumber: :rand.uniform(10_000_000),
            fnNumber: :rand.uniform(10_000_000) |> Integer.to_string(),
            registrationNumber: :rand.uniform(10_000_000) |> Integer.to_string(),
            shiftNumber: :rand.uniform(10_000_000),
            total: 500,
            fnsUrl: "www.nalog.ru"
  use ExConstructor

  def get() do

    {:ok, current_time} = DateTime.now("Asia/Yekaterinburg")
    current_time_iso = DateTime.to_iso8601(current_time)

     %{
       fiscalDocumentDateTime: current_time_iso,
       registrationNumber: "0000000001002292",  # TODO: Взять из настроек
       shiftNumber:  Atol.Shifts.get().number,
       total: 500  # TODO: Считать из чека
     }
     |> FiscalParams.new()
  end
end
