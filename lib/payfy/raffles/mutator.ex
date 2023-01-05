defmodule Payfy.Raffles.Mutator do
  alias Payfy.{Repo, Raffles}

  def create_raffle(params) do
    Repo.transaction(fn ->
      params
      |> Raffles.Schema.changeset()
      |> Repo.insert()
    end)
    |> case do
      {:ok, data} -> data
      error -> error
    end
  end

  def add_user(user, raffle) do
    case Raffles.Schema.add_user_changeset(raffle, user) do
      %{valid?: true} = changeset -> Repo.update(changeset)
      error -> error
    end
  end

  def set_winner(raffle, winner_id) do
    raffle
    |> Raffles.Schema.changeset(%{winner_id: winner_id, active: false})
    |> Repo.update()
  end
end
