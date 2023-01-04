defmodule Payfy.Raffles.UseCaseTest do
  use ExUnit.Case
  use Payfy.DataCase

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
end
