defmodule IgnitionHub.Repo do
  use Ecto.Repo,
    otp_app: :ignition_hub,
    adapter: Ecto.Adapters.Postgres
end
