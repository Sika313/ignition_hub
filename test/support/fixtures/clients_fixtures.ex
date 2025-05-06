defmodule IgnitionHub.CLIENTSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IgnitionHub.CLIENTS` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        fname: "some fname",
        gender: "some gender",
        lname: "some lname",
        password: "some password",
        phone: "some phone",
        token: "some token"
      })
      |> IgnitionHub.CLIENTS.create_client()

    client
  end
end
