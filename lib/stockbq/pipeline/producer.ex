defmodule Stockbq.Pipeline.Producer do
  use GenStage
  require Logger

  def start_link(_args) do
    GenStage.start_link(Stockbq.Pipeline.Producer, 0, name: Stockbq.Pipeline.Producer)
  end

  def init(state) do
    {:producer, state}
  end

  def handle_cast(event, state) do
    {:noreply, [event], state+1}
  end

  def handle_demand(demand, state) when demand > 0 do
    Logger.info(demand)
    Logger.info(state)

    events = Enum.to_list(0..demand-1)
    Logger.info("events emitted: #{Kernel.length(events)}")
    {:noreply, events, 0}
  end
end
