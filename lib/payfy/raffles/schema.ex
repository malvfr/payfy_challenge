defmodule Payfy.Raffles.Schema do
  use Payfy.Schema
  alias Payfy.Users
  import Ecto.Changeset

  schema "raffles" do
    field :active, :boolean, default: false
    field :date, :utc_datetime
    field :name, :string

    many_to_many :users, Users.Schema,
      join_through: "users_raffles",
      join_keys: [user_id: :id, raffle_id: :id],
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(schema \\ %__MODULE__{}, attrs) do
    schema
    |> cast(attrs, [:name, :date, :active])
    |> validate_required([:name, :date, :active])
    |> validate_change(:date, fn _, date ->
      if DateTime.compare(date, DateTime.utc_now()) == :lt do
        [date: "Cannot be earlier than today!"]
      else
        []
      end
    end)
  end
end
