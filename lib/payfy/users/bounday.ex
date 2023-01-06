defmodule Payfy.Users.Boundary do
  @timeout 5000
  @worker_pool :user_worker

  def create_user(params) do
    Task.async(fn ->
      :poolboy.transaction(
        @worker_pool,
        fn pid -> GenServer.call(pid, {:create_user, params}) end,
        @timeout
      )
    end)
    |> Task.await()
  end
end
