defmodule Stockbq.Pipeline.RateLimiter do
  use GenStage
  require Logger

  alias Stockbq.Pipeline.Producer
  alias Stockbq.Pipeline.RateLimiter

  def start_link(_args) do
    GenStage.start_link(RateLimiter, %{})
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [{Producer, min_demand: 1, max_demand: 10}]}
  end

  def handle_events(events, from, state) do
    IO.inspect(events)
    Logger.info(from)
    Logger.info(state)

    {:noreply, events, state}
  end
end
