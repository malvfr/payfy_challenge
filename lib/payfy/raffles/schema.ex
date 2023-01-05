defmodule Payfy.Raffles.Schema do
  use Payfy.Schema
  alias Payfy.Users
  import Ecto.Changeset

  schema "raffles" do
    field :date, :utc_datetime
    field :name, :string
    field :winner_id, :binary_id, references: Users.Schema, default: nil

    many_to_many :users, Users.Schema,
      join_through: "users_raffles",
      join_keys: [user_id: :id, raffle_id: :id],
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(schema \\ %__MODULE__{}, attrs) do
    schema
    |> cast(attrs, [:name, :date, :winner_id])
    |> validate_required([:name, :date])
  end

  def add_user_changeset(schema = %__MODULE__{}, user) do
    user
    |> Ecto.Changeset.change()
    |> put_assoc(:raffles, [schema | user.raffles])
  end
end
