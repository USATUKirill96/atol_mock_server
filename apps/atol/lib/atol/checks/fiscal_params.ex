defmodule Atol.Checks.FiscalParams do

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
end
