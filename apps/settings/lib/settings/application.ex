defmodule Settings.Application do
  @moduledoc false

  use Application
  alias Settings.Storage.{Memory, Disk}

  @impl true
  def start(_type, _args) do
    children = [
      Disk,
      Memory
    ]

    opts = [strategy: :one_for_one, name: Settings.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
