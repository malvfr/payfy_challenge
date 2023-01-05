defmodule Payfy.Raffles.UseCase do
  alias Payfy.{Raffles, Users}

  def create_raffle(params) do
    Raffles.Mutator.create_raffle(params)
  end

  def get_raffle_by_id(id) do
    Raffles.Loader.by_id(id)
  end

  def get_all() do
    Raffles.Loader.get_all()
  end

  def join_raffle(%{"user_id" => user_id, "raffle_id" => raffle_id}) do
    with user when not is_nil(user) <- Users.UseCase.get_user_by_id(user_id),
         raffle when not is_nil(raffle) <- get_raffle_by_id(raffle_id),
         true <- raffle_active?(raffle) do
      Raffles.Mutator.add_user(user, raffle)
    end
  end

  def raffle_result(raffle_id) do
    with raffle when not is_nil(raffle) <- get_raffle_by_id(raffle_id),
         false <- raffle_active?(raffle),
         raffle_winner <- Users.UseCase.get_user_by_id(raffle.winner_id) do
      {:ok, raffle_winner}
    else
      true -> {:ok, :ongoing}
    end
  end

  def raffle_active?(raffle) do
    DateTime.compare(raffle.date, DateTime.utc_now()) == :gt
  end
end
