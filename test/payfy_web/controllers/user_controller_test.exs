defmodule PayfyWeb.UserControllerTest do
  use PayfyWeb.ConnCase
  alias Payfy.Users

  describe "index/2" do
    test "should list one user", %{conn: conn} do
      {:ok, %{id: user_id}} =
        Users.UseCase.create_user(%{name: "Some name", email: "valid@email.com"})

      conn = get(conn, Routes.user_path(conn, :index))
      assert [%{"id" => ^user_id}] = json_response(conn, 200)["data"]
    end

    test "should list all users", %{conn: conn} do
      Users.UseCase.create_user(%{name: "Some name", email: "valid@email.com"})
      Users.UseCase.create_user(%{name: "Some name 2", email: "valid2@email.com"})

      conn = get(conn, Routes.user_path(conn, :index))
      assert length(json_response(conn, 200)["data"]) == 2
    end

    test "should return an empty list when there are no users in the database", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create/2" do
    test "should create one user", %{conn: conn} do
      params = %{"user" => %{"name" => "Some name", "email" => "valid@email.com"}}

      conn = post(conn, Routes.user_path(conn, :create, params))
      assert json_response(conn, 200)["data"]
    end
  end
end
