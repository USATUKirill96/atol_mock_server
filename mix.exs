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

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:tz, "~> 0.12.0"}, # Расширяет набор часовых поясов
      {:poison, "~> 3.1"} # Работа с JSON
    ]
  end

end
