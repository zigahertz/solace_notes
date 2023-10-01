defmodule Solace.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SolaceWeb.Telemetry,
      # Start the Ecto repository
      Solace.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Solace.PubSub},
      # Start Finch
      {Finch, name: Solace.Finch},
      # Start the Endpoint (http/https)
      SolaceWeb.Endpoint
      # Start a worker by calling: Solace.Worker.start_link(arg)
      # {Solace.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Solace.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SolaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
