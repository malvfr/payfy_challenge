defmodule Payfy.Users.Mutator do
  alias Payfy.{Repo, Users}

  def create_user(params) do
    Repo.transaction(fn ->
      params
      |> Users.Schema.changeset()
      |> Repo.insert()
    end)
    |> case do
      {:ok, data} -> data
      error -> error
    end
  end
end
