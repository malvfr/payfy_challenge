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
end
