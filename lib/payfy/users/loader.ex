defmodule Payfy.Users.Loader do
  alias Payfy.{Repo, Users}

  def by_id(id, preloads \\ [:raffles]) do
    Users.Schema
    |> Repo.get(id)
    |> Repo.preload(preloads)
  end

  def get_all() do
    Repo.all(Users.Schema)
  end
end
