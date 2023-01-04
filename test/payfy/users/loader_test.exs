defmodule Payfy.Users.LoaderTest do
  use ExUnit.Case
  use Payfy.DataCase

  alias Payfy.Users.{Loader, Mutator}

  describe "by_id/1" do
    setup do
      params = %{name: "My name", email: "valid@email.com"}

      {:ok, user} = Mutator.create_user(params)

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

  describe "get_all/0" do
    test "Should load all users" do
      for cur <- 1..3 do
        Mutator.create_user(%{name: "name", email: "valid@email#{cur}"})
      end

      assert length(Loader.get_all()) == 3
    end

    test "Should return empty when there are no users" do
      assert Loader.get_all() == []
    end
  end
end
