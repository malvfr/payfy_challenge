defmodule Payfy.Users.MutatorTest do
  use ExUnit.Case
  use Payfy.DataCase

  alias Payfy.Users.Mutator

  describe "create_user/1" do
    test "Should create new users with valid parameters" do
      params = %{name: "My name", email: "valid@email.com"}

      assert {:ok, %{email: "valid@email.com", name: "My name"}} = Mutator.create_user(params)
    end

    test "Should not create new users with invalid parameters" do
      params = %{name: "My name", email: "invalidEmail.com"}

      assert {:error, %{valid?: false}} = Mutator.create_user(params)
    end

    test "Should not create two users with the same email" do
      params = %{name: "My name", email: "valid@email.com"}

      Mutator.create_user(params)

      assert {:error, :rollback} = Mutator.create_user(params)
    end
  end
end
