defmodule Dashboard.MixProject do
  use Mix.Project

  def project do
    [
      app: :dashboard,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :event_bus, :jason, :exconstructor],
      mod: {Dashboard.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Генерация ID для шины данных
      {:uuid, "~> 1.1"},
      # EventBus
      {:event_bus, "~> 1.6.2"},
      # Работа с JSON
      {:jason, "~> 1.2"},
      # Работа со структурами
      {:exconstructor, "~> 1.1"}
    ]
  end
end
