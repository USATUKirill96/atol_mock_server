defmodule AtolServer.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: [plt_add_apps: [:mix]]
    ]
  end

  defp deps do
    [
      # Анализ кода
      {:dialyxir, "~> 0.4", only: [:dev]}
    ]
  end

  defp aliases do
    [
      setup: "load_fixtures"
    ]
  end
end
