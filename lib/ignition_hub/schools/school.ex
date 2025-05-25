defmodule IgnitionHub.SCHOOLS.School do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schools" do
    belongs_to :client, Client, foreign_key: :client_id, type: :id
    field :location, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [:name, :location, :client_id])
    |> validate_required([:name, :location, :client_id])
  end
end
