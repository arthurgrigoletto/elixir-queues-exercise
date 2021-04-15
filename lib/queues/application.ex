defmodule Queues.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Queues.Repo,
      # Start the Telemetry supervisor
      QueuesWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Queues.PubSub},
      # Start the Endpoint (http/https)
      QueuesWeb.Endpoint
      # Start a worker by calling: Queues.Worker.start_link(arg)
      # {Queues.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Queues.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QueuesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
