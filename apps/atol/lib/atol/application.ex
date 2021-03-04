defmodule Atol.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Atol.{Checks, Devices, FiscalStorages, Reports, Shifts, Tasks}

  @impl true
  def start(_type, _args) do
    children = [
      Checks.Server,
      Devices.Server,
      FiscalStorages.Server,
      Reports.Server,
      Shifts.Server,

      Devices.State,
      FiscalStorages.State,
      Shifts.State,

      Tasks
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Atol.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
