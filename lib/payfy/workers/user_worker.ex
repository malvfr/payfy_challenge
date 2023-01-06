defmodule Payfy.Workers.UserWorker do
  alias Payfy.Users
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:create_user, params}, _from, state) do
    user = Users.UseCase.create_user(params)
    {:reply, user, state}
  end
end
