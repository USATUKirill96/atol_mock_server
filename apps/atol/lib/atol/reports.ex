defmodule Atol.Reports do
  alias Atol.Reports.Server
  def print_report_x(uuid) do
    Server.cast({:printReportX, uuid})
  end
end
