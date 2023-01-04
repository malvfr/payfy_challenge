defmodule PayfyWeb.UserController do
  use PayfyWeb, :controller

  alias Payfy.Users

  action_fallback PayfyWeb.FallbackController

  def index(conn, _params) do
    with users <- Users.UseCase.get_all() do
      render(conn, "index.json", users: users)
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, {:ok, user}} <- Users.UseCase.create_user(user_params) do
      render(conn, "show.json", user: user)
    end
  end
end
