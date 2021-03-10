defmodule ApiWeb.RequestController do
  @moduledoc """
    Взаимодействие с реквестами от клиента

    Клиентское приложение передает JSON команды вида %{"request" => %{"type" => `type`}, "uuid" => uuid}
    Контроллер роутит команду на бизнес-логику в зависимости от значения `type`, а также валидирует данные
    согласно схеме команды
  """

  use ApiWeb, :controller
  require Logger
  alias Atol.{Checks, Devices, FiscalStorages, Reports, Shifts}
  alias EventBus.Model.Event

  plug :validate_request

  def create(conn, params) do
    route(params)

    conn
    |> put_status(200)
    |> json(%{"status" => "ok"})
  end

  @doc """
  Валидация реквеста согласно схеме. Если по ключу реквеста имеется схема, и все данные ей соответствуют,
  будет выполняться бизнес-логика контроллера. В противном случае, сразу вернется 400 ошибка,
  и будет создан :error евент
  """
  def validate_request(conn, _) do
    Api.Validator.validate(conn.params)
    |> case do
      {:error, errors} ->
        create_event(%{"Запрос" => conn.params, "Ошибки" => errors}, :errors)

        conn
        |> put_status(400)
        |> json(%{"status" => "error"})
        |> halt()

      :ok ->
        conn
        |> put_status(200)
    end
  end

  @doc """
  Роутинг реквеста на бизнес-логику приложения Atol. Сервер АТОЛ роутит задачи не через путь, а через атрибут "key",
  поэтому разветвление логики по таскам происхоит здесь.
  """
  def route(params) do
    %{"request" => %{"type" => type}, "uuid" => uuid} = params
    create_event(params, :api_events)

    case type do
      "getShiftStatus" -> Shifts.get_status(uuid)
      "getFnInfo" -> FiscalStorages.get_info(uuid)
      "getDeviceInfo" -> Devices.get_info(uuid)
      "getDeviceParameters" -> Devices.get_parameters(uuid, keys(params))
      "setDeviceParameters" -> Devices.set_parameters(uuid, device_parameters(params))
      "sell" -> Checks.sell(uuid)
      "sellReturn" -> Checks.sell_return(uuid)
      "continuePrint" -> Checks.continue_print(uuid)
      "reportX" -> Reports.print_report_x(uuid)
      "openShift" -> Shifts.open(uuid, name(params))
      "closeShift" -> Shifts.close(uuid)
      _ -> Logger.warning("Неизвестный запрос")
    end
  end

  @doc """
  Создать ивент в шине данных, чтобы дашборд мог вывести информацию о реквесте пользователю
  """
  def create_event(data, topic) do
    %Event{id: UUID.uuid4(), topic: topic, data: data}
    |> EventBus.notify()
  end

  # Парсеры данных из реквеста для передачи в слой бизнес-логики

  @spec keys(map) :: list(integer)
  def keys(%{"request" => %{"keys" => keys}}) do
    keys
  end

  @spec name(map) :: String.t()
  def name(%{"request" => %{"operator" => %{"name" => name}}}) do
    name
  end

  @spec device_parameters(map) :: list(map)
  def device_parameters(%{"request" => %{"deviceParameters" => parameters}}) do
    parameters
  end
end
