defmodule Atol.FiscalStorages.FiscalStorage do
  alias __MODULE__
  alias Atol.Storage

  @type t :: %__MODULE__{
          number_of_registrations: integer,
          registrations_remaining: integer,
          serial: String.t(),
          live_phase: String.t(),
          ffd_version: String.t(),
          fn_ffd_version: String.t(),
          validity_date: String.t(),
          warnings: String.t()
        }

  defstruct number_of_registrations: 1,
            registrations_remaining: 29,
            serial: "7043675145990",
            live_phase: "fiscalMode",
            ffd_version: "1.05",
            fn_ffd_version: "1.0",
            validity_date: "2050-04-15T21:00:00+03:00",
            warnings: nil

  use ExConstructor

  def get() do
    Storage.get(:fiscal_storage)
    |> FiscalStorage.new()
  end

  def update(fiscal_storage_Settings) do
    fiscal_storage_Settings
    |> FiscalStorage.new()
    |> Storage.update(:fiscal_storage)
  end
end
