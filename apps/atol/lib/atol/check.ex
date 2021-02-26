defmodule Atol.Check do

  def sell(uuid) do

    {:ok, dt} = DateTime.now("Asia/Yekaterinburg")
    %{
    "fiscalParams" => %{
      "fiscalDocumentDateTime" => "#{dt.year}-#{dt.month}-#{dt.day}T#{dt.hour}:#{dt.minute}:#{dt.second}+05:00",
      "fiscalDocumentNumber" =>:rand.uniform(10000000),
      "fiscalDocumentSign" => :rand.uniform(1000000),
      "fiscalReceiptNumber" => :rand.uniform(10000000),
      "fnNumber" => :rand.uniform(10000000),
      "registrationNumber" => "0000000001002292",
      "shiftNumber" => 12,
      "total" => 500,
      "fnsUrl"=> "www.nalog.ru"
    },
    "warnings"=> nil
  }

    |>Tasks.add(uuid)
  end

  # Ответ на печать чека прихода не отличается от чека возврата. При текущем функционале можно делегировать задачу
  def sell_return(uuid) do sell(uuid) end

  def continue_print(uuid) do Tasks.add("it's fine", uuid) end

end