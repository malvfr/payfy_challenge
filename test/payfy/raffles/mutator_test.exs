defmodule Payfy.Raffles.MutatorTest do
  use ExUnit.Case
  use Payfy.DataCase

  alias Payfy.{Repo, Users}
  alias Payfy.Raffles.Mutator

  describe "create_raffle/1" do
    test "Should create new raffles with valid parameters" do
      params = %{name: "My name", date: ~U[2023-12-31 00:00:00Z]}

      assert {:ok, %{date: ~U[2023-12-31 00:00:00Z], name: "My name"}} =
               Mutator.create_raffle(params)
    end

    test "Should not create new raffles with invalid parameters - Date being earlier than the current date" do
      params = %{name: "My name", date: ~U[2020-12-31 00:00:00Z]}

      assert {:error, %{valid?: false}} = Mutator.create_raffle(params)
    end
  end

  describe "add_user/2" do
    setup do
      params = %{name: "My name", email: "valid@email.com"}
      {:ok, user} = Users.Mutator.create_user(params)
      user = Repo.preload(user, :raffles)

      params = %{name: "My name", date: ~U[2023-12-31 00:00:00Z]}
      {:ok, raffle} = Mutator.create_raffle(params)

      raffle = Repo.preload(raffle, :users)

      {:ok, %{user: user, raffle: raffle}}
    end

    test "Should return the user struct, containing the joined raffles",
         %{user: user, raffle: raffle} do
      raffle_id = raffle.id
      assert {:ok, %{raffles: [%{id: ^raffle_id}]}} = Mutator.add_user(user, raffle)
    end
  end
end
