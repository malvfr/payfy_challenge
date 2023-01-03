defmodule Payfy.Raffles.Schema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raffles" do
    field :active, :boolean, default: false
    field :date, :utc_datetime
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:name, :date, :active])
    |> validate_required([:name, :date, :active])
  end
end
