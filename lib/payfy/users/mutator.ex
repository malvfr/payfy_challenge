defmodule Payfy.Users.Mutator do
  alias Payfy.{Repo, Users}

  def create_user(params) do
    Repo.wrap_transaction(fn ->
      params
      |> Users.Schema.changeset()
      |> Repo.insert()
    end)
  end
end
