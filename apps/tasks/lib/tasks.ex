defmodule Tasks do
  use Agent
  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(uuid) do
    Agent.get(__MODULE__, &(&1))
    |>Map.get(uuid)
  end

  def exists?(uuid) do Agent.get(__MODULE__, &(&1)) |>Map.has_key?(uuid) end

  def pop(uuid) do
    {task, new_state} = Agent.get(__MODULE__, &(&1)) |>Map.pop(uuid, nil)
    update_agent(new_state)
    task
  end

  def add(task, uuid) do
    Agent.get(__MODULE__, &(&1))
    |> Map.put(uuid, task)
    |> update_agent()
  end

  defp update_agent(new_state) do
    Agent.update(__MODULE__, fn (_) -> new_state end)
  end
end
