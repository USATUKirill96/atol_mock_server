defmodule ApiWeb.ResultController do
  use ApiWeb, :controller
  alias Atol.Tasks
  alias EventBus.Model.Event

  def index(conn, params) do
    %{"uuid" => [uuid]} = params

    {answer, status} = Tasks.pop(uuid) |> dump_result()

    create_event(uuid, status)

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

  defp create_event(uuid, status) do
    status
    |> case do
      404 ->
        %Event{
          id: UUID.uuid4(),
          topic: :errors,
          data: "Не найден результат для запроса с ID: #{uuid}"
        }
        |> EventBus.notify()

      200 ->
        %Event{
          id: UUID.uuid4(),
          topic: :api_events,
          data: "Запрошен результат выполнения задачи с ID #{uuid}"
        }
        |> EventBus.notify()
    end
  end
end
