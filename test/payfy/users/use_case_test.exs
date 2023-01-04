defmodule Payfy.Users.UseCaseTest do
  use ExUnit.Case
  use Payfy.DataCase

  alias Payfy.Users.{UseCase, Mutator}

  describe "get_user_by_id/1" do
    setup do
      params = %{name: "My name", email: "valid@email.com"}

      {:ok, {:ok, user}} = Mutator.create_user(params)

      {:ok, %{user: user}}
    end

    test "Should load user by ID", %{user: user} do
      id = user.id
      assert %{id: ^id} = UseCase.get_user_by_id(id)
    end

    test "Should handle inexistent IDs" do
      assert UseCase.get_user_by_id(Ecto.UUID.generate()) == nil
    end
  end

  describe "create_user/1" do
    test "Should create new users with valid parameters" do
      params = %{name: "My name", email: "valid@email.com"}

      assert {:ok, {:ok, %{email: "valid@email.com", name: "My name"}}} =
               UseCase.create_user(params)
    end
  end
end
