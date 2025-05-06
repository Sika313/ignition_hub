defmodule IgnitionHub.CARSTest do
  use IgnitionHub.DataCase

  alias IgnitionHub.CARS

  describe "cars" do
    alias IgnitionHub.CARS.Car

    import IgnitionHub.CARSFixtures

    @invalid_attrs %{engine_size: nil, engine_type: nil, make: nil, model: nil, price: nil, transmission: nil, year: nil}

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert CARS.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert CARS.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      valid_attrs = %{engine_size: "some engine_size", engine_type: "some engine_type", make: "some make", model: "some model", price: "some price", transmission: "some transmission", year: ~D[2025-05-05]}

      assert {:ok, %Car{} = car} = CARS.create_car(valid_attrs)
      assert car.engine_size == "some engine_size"
      assert car.engine_type == "some engine_type"
      assert car.make == "some make"
      assert car.model == "some model"
      assert car.price == "some price"
      assert car.transmission == "some transmission"
      assert car.year == ~D[2025-05-05]
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CARS.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      update_attrs = %{engine_size: "some updated engine_size", engine_type: "some updated engine_type", make: "some updated make", model: "some updated model", price: "some updated price", transmission: "some updated transmission", year: ~D[2025-05-06]}

      assert {:ok, %Car{} = car} = CARS.update_car(car, update_attrs)
      assert car.engine_size == "some updated engine_size"
      assert car.engine_type == "some updated engine_type"
      assert car.make == "some updated make"
      assert car.model == "some updated model"
      assert car.price == "some updated price"
      assert car.transmission == "some updated transmission"
      assert car.year == ~D[2025-05-06]
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = CARS.update_car(car, @invalid_attrs)
      assert car == CARS.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = CARS.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> CARS.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = CARS.change_car(car)
    end
  end
end
