defmodule Payfy.Users.Schema do
  use Payfy.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string

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
