defmodule IgnitionHub.SCHOOLSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IgnitionHub.SCHOOLS` context.
  """

  @doc """
  Generate a school.
  """
  def school_fixture(attrs \\ %{}) do
    {:ok, school} =
      attrs
      |> Enum.into(%{
        location: "some location",
        name: "some name"
      })
      |> IgnitionHub.SCHOOLS.create_school()

    school
  end
end
