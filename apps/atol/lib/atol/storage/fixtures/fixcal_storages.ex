defmodule Atol.Storage.Fixtures.FiscalStorage do
  @moduledoc false

  def get() do
    {:fiscal_storage,
     %{
       number_of_registrations: 1,
       registrations_remaining: 29,
       serial: "9999078900008855",
       live_phase: "fiscalMode"
     }}
  end
end
