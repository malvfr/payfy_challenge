defmodule Payfy.Users.Mutator do
  alias Payfy.{Repo, Users}

  def create_user(params) do
    Repo.transaction(fn ->
      params
      |> Users.Schema.changeset()
      |> Repo.insert()
    end)
  end
end
