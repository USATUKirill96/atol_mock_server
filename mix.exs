defmodule AtolServer.MixProject do
  use Mix.Project

  def project do
    [
      name: :atol_server,
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
      {:dialyxir, "~> 0.4", only: [:dev]},
      # Рендеринг документации
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      setup: "load_fixtures"
    ]
  end
end
