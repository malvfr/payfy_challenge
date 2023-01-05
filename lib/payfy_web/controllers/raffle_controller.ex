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

  def join_raffle(conn, params) do
    with {:ok, _raffle} <- Raffles.UseCase.join_raffle(params) do
      send_resp(conn, 201, "OK")
    end
  end
end
