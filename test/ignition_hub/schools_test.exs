defmodule IgnitionHub.SCHOOLSTest do
  use IgnitionHub.DataCase

  alias IgnitionHub.SCHOOLS

  describe "schools" do
    alias IgnitionHub.SCHOOLS.School

    import IgnitionHub.SCHOOLSFixtures

    @invalid_attrs %{location: nil, name: nil}

    test "list_schools/0 returns all schools" do
      school = school_fixture()
      assert SCHOOLS.list_schools() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert SCHOOLS.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      valid_attrs = %{location: "some location", name: "some name"}

      assert {:ok, %School{} = school} = SCHOOLS.create_school(valid_attrs)
      assert school.location == "some location"
      assert school.name == "some name"
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SCHOOLS.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()
      update_attrs = %{location: "some updated location", name: "some updated name"}

      assert {:ok, %School{} = school} = SCHOOLS.update_school(school, update_attrs)
      assert school.location == "some updated location"
      assert school.name == "some updated name"
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = SCHOOLS.update_school(school, @invalid_attrs)
      assert school == SCHOOLS.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = SCHOOLS.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> SCHOOLS.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = SCHOOLS.change_school(school)
    end
  end
end
