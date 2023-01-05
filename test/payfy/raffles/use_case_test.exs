defmodule Payfy.Raffles.UseCaseTest do
  use ExUnit.Case
  use Payfy.DataCase

  alias Payfy.Users
  alias Payfy.Raffles.{UseCase, Mutator}

  describe "get_raffle_by_id/1" do
    setup do
      params = %{name: "My name", date: ~U[2023-12-31 00:00:00Z]}

      {:ok, raffle} = Mutator.create_raffle(params)

      {:ok, %{raffle: raffle}}
    end

    test "Should load raffle by ID", %{raffle: raffle} do
      id = raffle.id
      assert %{id: ^id} = UseCase.get_raffle_by_id(id)
    end

    test "Should handle inexistent IDs" do
      assert UseCase.get_raffle_by_id(Ecto.UUID.generate()) == nil
    end
  end

  describe "create_raffle/1" do
    test "Should create new raffles with valid parameters" do
      params = %{name: "My name", date: ~U[2023-12-31 00:00:00Z]}

      assert {:ok, %{date: ~U[2023-12-31 00:00:00Z], name: "My name"}} =
               UseCase.create_raffle(params)
    end
  end

  describe "raffle_active?/1" do
    test "Should return a boolean whether the raffle is active or not" do
      assert true == UseCase.raffle_active?(%{date: ~U[9999-12-31 00:00:00Z]})
      assert false == UseCase.raffle_active?(%{date: ~U[0001-12-31 00:00:00Z]})
    end
  end

  describe "join_raffle/2" do
    setup do
      params = %{name: "My name", email: "valid@email.com"}
      {:ok, user} = Users.Mutator.create_user(params)

      params = %{name: "My name", date: ~U[2023-12-31 00:00:00Z]}
      {:ok, raffle} = Mutator.create_raffle(params)

      {:ok, %{user: user, raffle: raffle}}
    end

    test "Should return the user struct, containing the joined raffles",
         %{user: %{id: user_id}, raffle: %{id: raffle_id}} do
      params = %{"user_id" => user_id, "raffle_id" => raffle_id}
      assert {:ok, %{raffles: [%{id: ^raffle_id}]}} = UseCase.join_raffle(params)
    end

    test "Should join multiple raffles",
         %{user: %{id: user_id}, raffle: %{id: raffle_id}} do
      params = %{"user_id" => user_id, "raffle_id" => raffle_id}
      assert {:ok, %{raffles: [%{id: ^raffle_id}]}} = UseCase.join_raffle(params)

      new_raffle_params = %{name: "Second Raffle", date: ~U[2024-12-31 00:00:00Z]}
      {:ok, %{id: raffle_2_id}} = Mutator.create_raffle(new_raffle_params)
      new_raffle_join_params = %{"user_id" => user_id, "raffle_id" => raffle_2_id}

      assert {:ok, %{raffles: [%{id: ^raffle_2_id}, %{id: ^raffle_id}]}} =
               UseCase.join_raffle(new_raffle_join_params)
    end
  end
end
