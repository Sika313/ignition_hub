defmodule IgnitionHub.CLIENTS.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    belongs_to :tier, Tier, foreign_key: :tier_id, type: :id
    field :fname, :string
    field :gender, :string
    field :lname, :string
    field :password, :string
    field :phone, :string
    field :token, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:fname, :lname, :gender, :phone, :password, :token, :tier_id])
    |> validate_required([:fname, :lname, :gender, :phone, :password, :token, :tier_id])
  end
end
