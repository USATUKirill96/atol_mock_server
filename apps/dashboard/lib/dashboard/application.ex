defmodule Dashboard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Dashboard.Consumer,
      Dashboard.Storage
    ]

    opts = [strategy: :one_for_one, name: Dashboard.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
