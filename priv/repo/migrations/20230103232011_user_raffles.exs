defmodule Payfy.Repo.Migrations.UserRaffles do
  use Ecto.Migration

  def change do
    create table(:users_raffles) do
      add :user_id, references(:users, type: :uuid)
      add :raffle_id, references(:raffles, type: :uuid)
    end

    create unique_index(:users_raffles, [:user_id, :raffle_id])
  end
end
