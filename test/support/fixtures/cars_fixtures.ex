defmodule IgnitionHub.CARSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `IgnitionHub.CARS` context.
  """

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> Enum.into(%{
        engine_size: "some engine_size",
        engine_type: "some engine_type",
        make: "some make",
        model: "some model",
        price: "some price",
        transmission: "some transmission",
        year: ~D[2025-05-05]
      })
      |> IgnitionHub.CARS.create_car()

    car
  end
end
