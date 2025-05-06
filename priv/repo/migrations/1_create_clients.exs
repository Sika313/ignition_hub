defmodule IgnitionHub.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :fname, :string
      add :lname, :string
      add :gender, :string
      add :phone, :string
      add :password, :string
      add :token, :string

      timestamps(type: :utc_datetime)
    end
  end
end
