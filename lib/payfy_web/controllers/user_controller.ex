defmodule PayfyWeb.UserController do
  use PayfyWeb, :controller

  alias Payfy.Users

  action_fallback PayfyWeb.FallbackController

  def index(conn, _params) do
    #  render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    # render("show.json", user: user)
  end

  def show(conn, %{"id" => id}) do
    # render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    #  render(conn, "show.json", user: user)
  end

  def delete(conn, %{"id" => id}) do
    #  send_resp(conn, :no_content, "")
  end
end
