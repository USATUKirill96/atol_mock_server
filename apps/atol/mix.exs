defmodule Atol.MixProject do
  use Mix.Project

  def project do
    [
      app: :atol,
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
      extra_applications: [:logger, :exconstructor],
      mod: {Atol.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Работа со структурами
      {:exconstructor, "~> 1.1"},
      # Расширяет набор часовых поясов
      {:tz, "~> 0.12.0"},
      # Форматирование snake_case структур в camelCase
      {:recase, "~> 0.5"}
    ]
  end
end
