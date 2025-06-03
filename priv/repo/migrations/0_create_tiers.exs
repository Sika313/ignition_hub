defmodule IgnitionHub.Repo.Migrations.CreateTiers do
  use Ecto.Migration

  def change do
    create table(:tiers) do
      add :name, :string
      add :max_cars, :integer
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
