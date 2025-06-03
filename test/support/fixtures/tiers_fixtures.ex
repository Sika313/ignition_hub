defmodule IgnitionHub.TIERSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IgnitionHub.TIERS` context.
  """

  @doc """
  Generate a tier.
  """
  def tier_fixture(attrs \\ %{}) do
    {:ok, tier} =
      attrs
      |> Enum.into(%{
        description: "some description",
        max_cars: 42,
        name: "some name"
      })
      |> IgnitionHub.TIERS.create_tier()

    tier
  end
end
