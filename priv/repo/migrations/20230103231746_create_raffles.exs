defmodule Payfy.Repo.Migrations.CreateRaffles do
  use Ecto.Migration

  def change do
    create table(:raffles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :date, :utc_datetime, null: false
      add :active, :boolean, default: false, null: false

      timestamps()
    end
  end
end
