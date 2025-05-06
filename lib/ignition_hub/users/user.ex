defmodule IgnitionHub.USERS.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :fname, :string
    field :gender, :string
    field :lname, :string
    field :password, :string
    field :phone, :string
    field :token, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:fname, :lname, :gender, :phone, :password, :token])
    |> validate_required([:fname, :lname, :gender, :phone, :password, :token])
  end
end
