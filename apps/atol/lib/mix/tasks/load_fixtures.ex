defmodule Mix.Tasks.LoadFixtures do
  use Mix.Task
  @shortdoc "Загрузить фикстуры"
  def run(_) do
    Atol.Storage.Fixtures.load_fixtures()
  end
end
