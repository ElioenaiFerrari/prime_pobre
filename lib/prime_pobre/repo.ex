defmodule PrimePobre.Repo do
  use Ecto.Repo,
    otp_app: :prime_pobre,
    adapter: Ecto.Adapters.Postgres
end
