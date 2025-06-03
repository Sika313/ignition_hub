defmodule IgnitionHub.TIERS.Tier do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tiers" do
    field :description, :string
    field :max_cars, :integer
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tier, attrs) do
    tier
    |> cast(attrs, [:name, :max_cars, :description])
    |> validate_required([:name, :max_cars, :description])
  end
end
