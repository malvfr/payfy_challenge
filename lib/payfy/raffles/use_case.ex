defmodule Payfy.Raffles.UseCase do
  alias Payfy.Raffles

  def create_raffle(params) do
    Raffles.Mutator.create_raffle(params)
  end

  def get_raffle_by_id(id) do
    Raffles.Loader.by_id(id)
  end

  def get_all() do
    Raffles.Loader.get_all()
  end
end
