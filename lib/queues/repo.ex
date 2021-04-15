defmodule Queues.Repo do
  use Ecto.Repo,
    otp_app: :queues,
    adapter: Ecto.Adapters.Postgres
end
