defmodule PayfyWeb.RaffleController do
  use PayfyWeb, :controller

  alias Payfy.Raffles

  action_fallback PayfyWeb.FallbackController

  def index(conn, _params) do
    with raffles <- Raffles.UseCase.get_all() do
      render(conn, "index.json", raffles: raffles)
    end
  end

  def create(conn, %{"raffle" => raffle_params}) do
    with {:ok, raffle} <- Raffles.UseCase.create_raffle(raffle_params) do
      render(conn, "show.json", raffle: raffle)
    end
  end
end
