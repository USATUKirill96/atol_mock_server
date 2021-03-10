defmodule Atol.FiscalStorages.Schema do
  @moduledoc """
  Функции преобразования структур модуля в задачи
  """

  alias Atol.FiscalStorages.FiscalStorage

  @spec get_fn_info(FiscalStorage.t()) :: map
  def get_fn_info(fiscal_storage) do
    fn_info_body =
      fiscal_storage
      |> Map.from_struct()
      |> Recase.Enumerable.convert_keys(&Recase.to_camel/1)

    %{"fnInfo" => fn_info_body}
  end
end
