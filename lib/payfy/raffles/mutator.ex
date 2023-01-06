defmodule Payfy.Raffles.Mutator do
  alias Payfy.{Repo, Raffles}

  def create_raffle(params) do
    Repo.wrap_transaction(fn ->
      params
      |> Raffles.Schema.changeset()
      |> Repo.insert()
    end)
  end

  def add_user(user, raffle) do
    Repo.wrap_transaction(fn ->
      case Raffles.Schema.add_user_changeset(raffle, user) do
        %{valid?: true} = changeset -> Repo.update(changeset)
        error -> error
      end
    end)
  end

  def set_winner(raffle, winner_id) do
    Repo.wrap_transaction(fn ->
      raffle
      |> Raffles.Schema.changeset(%{winner_id: winner_id, active: false})
      |> Repo.update()
    end)
  end
end
