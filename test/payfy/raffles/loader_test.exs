defmodule Payfy.Raffles.LoaderTest do
  use ExUnit.Case
  use Payfy.DataCase

  alias Payfy.Raffles.{Loader, Mutator}

  describe "by_id/1" do
    setup do
      params = %{name: "My raffle", date: ~U[2023-12-31 00:00:00Z]}

      {:ok, raffle} = Mutator.create_raffle(params)

      {:ok, %{raffle: raffle}}
    end

    test "Should load raffle by ID", %{raffle: raffle} do
      id = raffle.id
      assert %{id: ^id} = Loader.by_id(id)
    end

    test "Should handle inexistent IDs" do
      assert Loader.by_id(Ecto.UUID.generate()) == nil
    end
  end

  describe "get_all/0" do
    test "Should load all raffles" do
      for _cur <- 1..3 do
        Mutator.create_raffle(%{name: "name", date: ~U[2023-12-31 00:00:00Z]})
      end

      assert length(Loader.get_all()) == 3
    end

    test "Should return empty when there are no raffles" do
      assert Loader.get_all() == []
    end
  end
end
