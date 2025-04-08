defmodule IgnitionHub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      IgnitionHubWeb.Telemetry,
      IgnitionHub.Repo,
      {DNSCluster, query: Application.get_env(:ignition_hub, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: IgnitionHub.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: IgnitionHub.Finch},
      # Start a worker by calling: IgnitionHub.Worker.start_link(arg)
      # {IgnitionHub.Worker, arg},
      # Start to serve requests, typically the last entry
      IgnitionHubWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IgnitionHub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    IgnitionHubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
