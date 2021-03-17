defmodule FiscalStorageTest do
  alias Atol.FiscalStorages.{FiscalStorage, Schema}
  use ExUnit.Case

  setup do
    storage_data = %{number_of_registrations: 5, registrations_remaining: 40}
    {:ok, storage_data: storage_data}
  end

  test "get_fiscal_storage", state do
    fiscal_storage = state[:storage_data] |> FiscalStorage.get()
    assert fiscal_storage.number_of_registrations == 5
    assert fiscal_storage.registrations_remaining == 40
    assert %FiscalStorage{} = fiscal_storage
  end

  test "get_fn_info", state do
    _schema = state[:storage_data]
             |> FiscalStorage.get()
             |>Schema.get_fn_info()

    pattern = %{"fnInfo" => %{
        numberOfRegistrations: 1,
        registrationsRemaining: 29,
        serial: "7043675145990",
        livePhase: "fiscalMode",
        ffdVersion: "1.05",
        fnFfdVersion: "1.0",
        validityDate: "2050-04-15T21:00:00+03:00",
        warnings: nil
      }
    }

    assert _schema = pattern
  end
end