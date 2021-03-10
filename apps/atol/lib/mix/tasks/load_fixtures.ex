defmodule Mix.Tasks.LoadFixtures do
  @moduledoc """
  Загружает в хранилище данных фикстуры для инициализации дефолтных настроек приложения
  """

  use Mix.Task

  @shortdoc "Загрузить фикстуры"
  def run(_) do
    Atol.Storage.Fixtures.load_fixtures()
  end
end
