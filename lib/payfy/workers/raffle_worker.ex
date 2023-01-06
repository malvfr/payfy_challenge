defmodule Payfy.Workers.RaffleWorker do
  alias Payfy.Raffles
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:create_raffle, params}, _from, state) do
    raffle = Raffles.UseCase.create_raffle(params)
    {:reply, raffle, state}
  end

  def handle_call({:join_raffle, params}, _from, state) do
    raffle = Raffles.UseCase.join_raffle(params)
    {:reply, raffle, state}
  end
end
