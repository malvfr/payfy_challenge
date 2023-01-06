defmodule PayfyWeb.RaffleController do
  use PayfyWeb, :controller

  alias Payfy.{Raffles, Users}

  action_fallback PayfyWeb.FallbackController

  def index(conn, _params) do
    with raffles <- Raffles.UseCase.get_all() do
      render(conn, "index.json", raffles: raffles)
    end
  end

  def create(conn, %{"raffle" => raffle_params}) do
    with {:ok, raffle} <- Raffles.Boundary.create_raffle(raffle_params) do
      render(conn, "show.json", raffle: raffle)
    end
  end

  def join_raffle(conn, params) do
    with {:ok, _raffle} <- Raffles.Boundary.join_raffle(params) do
      send_resp(conn, 201, "OK")
    else
      {:error, :expired_raffle} ->
        json(conn, %{data: %{is_raffle_active: false, message: "Raffle is expired"}})
    end
  end

  def close_raffle(conn, %{"id" => raffle_id}) do
    with :ok <- Raffles.UseCase.close_raffle(raffle_id) do
      send_resp(conn, 204, "")
    end
  end

  def raffle_result(conn, %{"id" => raffle_id}) do
    with {:ok, raffle_winner = %Users.Schema{}} <- Raffles.UseCase.raffle_result(raffle_id) do
      render(conn, "winner.json", raffle_winner: raffle_winner)
    else
      {:ok, :ongoing} ->
        json(conn, %{data: %{is_raffle_active: true, message: "Raffle is still active"}})
    end
  end
end
