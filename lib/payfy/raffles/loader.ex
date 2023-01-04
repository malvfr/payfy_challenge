defmodule Payfy.Raffles.Loader do
  alias Payfy.{Repo, Raffles}

  def by_id(id, preloads \\ [:users]) do
    Raffles.Schema
    |> Repo.get(id)
    |> Repo.preload(preloads)
  end

  def get_all() do
    Repo.all(Raffles.Schema)
  end
end
