defmodule Settings.Application do
  @moduledoc false

  use Application
  alias Settings.{Storage, Shift, Device, FiscalStorage}

  @impl true
  def start(_type, _args) do
    children = [
      Storage,
      Shift,
      Device,
      FiscalStorage
    ]

    opts = [strategy: :one_for_one, name: Settings.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
