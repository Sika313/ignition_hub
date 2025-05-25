defmodule IgnitionHub.Repo.Migrations.CreateSchools do
  use Ecto.Migration

  def change do
    create table(:schools) do
      add :name, :string
      add :location, :string
      
      add :client_id, references(:clients, column: :id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end
