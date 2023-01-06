defmodule Payfy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Payfy.Repo,
      # Start the Telemetry supervisor
      PayfyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Payfy.PubSub},
      # Start the Endpoint (http/https)
      PayfyWeb.Endpoint,
      :poolboy.child_spec(:raffle_worker, poolboy_config(:raffle)),
      :poolboy.child_spec(:user_worker, poolboy_config(:user))
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Payfy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp poolboy_config(:raffle) do
    [
      name: {:local, :raffle_worker},
      worker_module: Payfy.Workers.RaffleWorker,
      size: 5,
      max_overflow: 2
    ]
  end

  defp poolboy_config(:user) do
    [
      name: {:local, :user_worker},
      worker_module: Payfy.Workers.UserWorker,
      size: 5,
      max_overflow: 2
    ]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PayfyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
