defmodule Payfy.Raffles.Schema do
  use Ecto.Schema
  alias Payfy.Users
  import Ecto.Changeset

  schema "raffles" do
    field :active, :boolean, default: false
    field :date, :utc_datetime
    field :name, :string

    many_to_many :users, Users.Schema, join_through: "users_raffles"

    timestamps()
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:name, :date, :active])
    |> validate_required([:name, :date, :active])
  end
end
