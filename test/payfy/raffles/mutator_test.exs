defmodule Payfy.Raffles.MutatorTest do
  use ExUnit.Case
  use Payfy.DataCase

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
end
