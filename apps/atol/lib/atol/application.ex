defmodule Atol.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Atol.Storage
  alias Atol.Tasks.{Check, Device, FiscalStorage, Queue, Reports, Shift}

  @impl true
  def start(_type, _args) do
    children = [
      Storage.Server,
      Check,
      Device,
      FiscalStorage,
      Queue,
      Reports,
      Shift
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Atol.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
