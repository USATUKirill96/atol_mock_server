defmodule ApiWeb.ResultController do
  use ApiWeb, :controller
  alias Atol.Tasks

  def index(conn, params) do
    %{"uuid" => [uuid]} = params

    {answer, status} = Tasks.pop(uuid) |> dump_result()

    conn
    |> put_status(status)
    |> json(answer)
  end

  # Если результат таски еще не получен
  defp dump_result(nil) do
    {"", 404}
  end

  defp dump_result(task) do
    answer = %{
      "results" => [
        %{
          "status" => "ready",
          "errorDescription" => "Ошибок нет",
          "result" => task
        }
      ]
    }

    {answer, 200}
  end
end
