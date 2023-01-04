defmodule Payfy.Users.Schema do
  use Payfy.Schema
  alias Payfy.Raffles
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string

    many_to_many :raffles, Raffles.Schema,
      join_through: "users_raffles",
      join_keys: [user_id: :id, raffle_id: :id],
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:email, message: "Email must be unique")
    |> validate_format(:email, ~r/@/)
  end
end
