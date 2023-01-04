defmodule Payfy.Users.LoaderTest do
  use ExUnit.Case
  use Payfy.DataCase

  alias Mix.Tasks.Ecto.Load
  alias Payfy.Users.{Loader, Mutator}

  describe "by_id/1" do
    setup do
      params = %{name: "My name", email: "valid@email.com"}

      {:ok, {:ok, user}} = Mutator.create_user(params)

      {:ok, %{user: user}}
    end

    test "Should load user by ID", %{user: user} do
      id = user.id
      assert %{id: ^id} = Loader.by_id(id)
    end

    test "Should handle inexistent IDs" do
      assert Loader.by_id(Ecto.UUID.generate()) == nil
    end
  end
end
