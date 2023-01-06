defmodule Payfy.Repo do
  use Ecto.Repo,
    otp_app: :payfy,
    adapter: Ecto.Adapters.Postgres

  def wrap_transaction(func) do
    Payfy.Repo.transaction(fn -> func.() end)
    |> case do
      {:ok, data} -> data
      error -> error
    end
  end
end
