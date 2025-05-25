defmodule IgnitionHub.Repo.Migrations.ChangeLocationTypeToText do
  use Ecto.Migration

  def change do
    alter table(:schools) do
      modify :location, :text
    end
  end
end
