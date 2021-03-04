defmodule Atol.FiscalStorages do
  alias Atol.FiscalStorages.Server

  def get_info(uuid) do
    Server.call({:getFnInfo, uuid})
  end
end
