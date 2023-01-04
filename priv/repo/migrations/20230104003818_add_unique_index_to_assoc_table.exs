defmodule Payfy.Repo.Migrations.AddUniqueIndexToAssocTable do
  use Ecto.Migration

  def change do
    create unique_index(:users_raffles, [:user_id, :raffle_id],
             name: :user_raffle_unique_constraint
           )
  end
end
