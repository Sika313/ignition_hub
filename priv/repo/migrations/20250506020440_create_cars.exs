defmodule IgnitionHub.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :make, :string
      add :model, :string
      add :year, :date
      add :engine_type, :string
      add :engine_size, :string
      add :transmission, :string
      add :price, :string
      add :pic_one, :string
      add :pic_two, :string
      add :pic_three, :string
      add :pic_four, :string
      add :client_id, references(:clients, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
