defmodule Payfy.Repo.Migrations.AddWinnerColumn do
  use Ecto.Migration

  def change do
    alter table(:raffles) do
      add :winner_id, references(:users, type: :uuid)
    end
  end
end
