defmodule Solace.Repo do
  use Ecto.Repo,
    otp_app: :solace,
    adapter: Ecto.Adapters.Postgres
end
