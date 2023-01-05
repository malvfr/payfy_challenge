defmodule PayfyWeb.RaffleControllerTest do
  use PayfyWeb.ConnCase
  alias Payfy.{Raffles, Users}

  describe "index/2" do
    test "should list one raffle", %{conn: conn} do
      {:ok, %{id: raffle_id}} =
        Raffles.UseCase.create_raffle(%{name: "Some name", date: ~U[2023-12-31 00:00:00Z]})

      conn = get(conn, Routes.raffle_path(conn, :index))
      assert [%{"id" => ^raffle_id}] = json_response(conn, 200)["data"]
    end

    test "should list all raffles", %{conn: conn} do
      Raffles.UseCase.create_raffle(%{name: "Some name", date: ~U[2023-12-31 00:00:00Z]})
      Raffles.UseCase.create_raffle(%{name: "Some name 2", date: ~U[2025-12-30 00:00:00Z]})

      conn = get(conn, Routes.raffle_path(conn, :index))
      assert length(json_response(conn, 200)["data"]) == 2
    end

    test "should return an empty list when there are no raffles in the database", %{conn: conn} do
      conn = get(conn, Routes.raffle_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create/2" do
    test "should create one raffle", %{conn: conn} do
      params = %{"raffle" => %{"name" => "Some name", "date" => "2023-12-31 00:00:00Z"}}

      conn = post(conn, Routes.raffle_path(conn, :create, params))
      assert json_response(conn, 200)["data"]
    end
  end

  describe "user_raffle" do
    setup do
      params = %{name: "My name", email: "valid@email.com"}
      {:ok, user} = Users.Mutator.create_user(params)

      params = %{name: "My name", date: ~U[2023-12-31 00:00:00Z]}
      {:ok, raffle} = Raffles.Mutator.create_raffle(params)

      {:ok, %{user: user, raffle: raffle}}
    end

    test "should add user to a raffle", %{
      conn: conn,
      user: %{id: user_id},
      raffle: %{id: raffle_id}
    } do
      params = %{"user_id" => user_id, "raffle_id" => raffle_id}

      conn = post(conn, Routes.raffle_path(conn, :join_raffle, params))
      assert response(conn, 201)
    end
  end
end
