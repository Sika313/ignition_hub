defmodule IgnitionHub.CARS.Car do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cars" do
    belongs_to :user, User, foreign_key: :client_id, type: :id 
    field :engine_size, :string
    field :engine_type, :string
    field :make, :string
    field :model, :string
    field :price, :string
    field :transmission, :string
    field :year, :string
    field :pic_one, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:make, :model, :year, :engine_type, :engine_size, :transmission, :price, :client_id, :pic_one])
    |> validate_required([:make, :model, :year, :engine_type, :engine_size, :transmission, :price, :client_id, :pic_one])
  end
end
