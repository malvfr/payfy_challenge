defmodule Payfy.Raffles.Boundary do
  @timeout 5000
  @worker_pool :raffle_worker

  def create_raffle(params) do
    wrap_async(fn pid -> GenServer.call(pid, {:create_raffle, params}) end)
  end

  def join_raffle(params) do
    wrap_async(fn pid -> GenServer.call(pid, {:join_raffle, params}) end)
  end

  defp wrap_async(func) do
    Task.async(fn ->
      :poolboy.transaction(
        @worker_pool,
        fn pid -> func.(pid) end,
        @timeout
      )
    end)
    |> Task.await()
  end
end
