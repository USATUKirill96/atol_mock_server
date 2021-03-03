defmodule AtolServer.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end


  def application do
    [applications: [:exconstructor]]
  end


  defp deps do
    [
      {:tz, "~> 0.12.0"}, # Расширяет набор часовых поясов
      {:exconstructor, "~> 1.1"}  # Работа со структурами
    ]
  end

end
