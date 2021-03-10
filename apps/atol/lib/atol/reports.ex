defmodule Atol.Reports do
  alias Atol.Reports.Server

  @spec print_report_x(integer) :: :ok
  def print_report_x(uuid) do
    Server.cast({:printReportX, uuid})
  end
end
