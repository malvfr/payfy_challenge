defmodule PayfyWeb.RaffleView do
  use PayfyWeb, :view
  alias PayfyWeb.UserView
  alias PayfyWeb.RaffleView

  def render("index.json", %{raffles: raffles}) do
    %{data: render_many(raffles, RaffleView, "raffle.json")}
  end

  def render("show.json", %{raffle: raffle}) do
    %{data: render_one(raffle, RaffleView, "raffle.json")}
  end

  def render("create.json", %{raffle: raffle}) do
    %{data: render_one(raffle, RaffleView, "create_raffle.json")}
  end

  def render("raffle.json", %{raffle: raffle}) do
    %{
      id: raffle.id,
      date: raffle.date,
      name: raffle.name,
      active: raffle.active,
      participants: render_many(raffle.users, UserView, "user.json")
    }
  end

  def render("create_raffle.json", %{raffle: raffle}) do
    %{
      id: raffle.id,
      date: raffle.date,
      name: raffle.name,
      active: raffle.active
    }
  end

  def render("winner.json", %{raffle_winner: raffle_winner}) do
    %{
      data: %{
        id: raffle_winner.id,
        email: raffle_winner.email,
        name: raffle_winner.name
      }
    }
  end
end
