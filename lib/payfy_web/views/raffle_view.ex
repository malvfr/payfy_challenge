defmodule PayfyWeb.RaffleView do
  use PayfyWeb, :view
  alias PayfyWeb.RaffleView

  def render("index.json", %{raffles: raffles}) do
    %{data: render_many(raffles, RaffleView, "raffle.json")}
  end

  def render("show.json", %{raffle: raffle}) do
    %{data: render_one(raffle, RaffleView, "raffle.json")}
  end

  def render("raffle.json", %{raffle: raffle}) do
    %{
      id: raffle.id,
      date: raffle.date,
      name: raffle.name
    }
  end
end
