defmodule Atol.Tasks.Queue do
  @moduledoc """
  Управление очередью задач
  """

  use Agent

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @spec get(String.t()) :: map | nil
  def get(uuid) do
    Agent.get(__MODULE__, & &1)
    |> Map.get(uuid)
  end

  @spec exists?(String.t()) :: boolean
  def exists?(uuid) do
    Agent.get(__MODULE__, & &1) |> Map.has_key?(uuid)
  end

  @spec pop(String.t()) :: map | nil
  def pop(uuid) do
    {task, new_state} = Agent.get(__MODULE__, & &1) |> Map.pop(uuid, nil)
    update_agent(new_state)
    task
  end

  @spec add(map, String.t()) :: :ok
  def add(task, uuid) do
    Agent.get(__MODULE__, & &1)
    |> Map.put(uuid, task)
    |> update_agent()
  end

  defp update_agent(new_state) do
    Agent.update(__MODULE__, fn _ -> new_state end)
  end
end
