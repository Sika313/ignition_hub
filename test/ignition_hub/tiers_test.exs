defmodule IgnitionHub.TIERSTest do
  use IgnitionHub.DataCase

  alias IgnitionHub.TIERS

  describe "tiers" do
    alias IgnitionHub.TIERS.Tier

    import IgnitionHub.TIERSFixtures

    @invalid_attrs %{description: nil, max_cars: nil, name: nil}

    test "list_tiers/0 returns all tiers" do
      tier = tier_fixture()
      assert TIERS.list_tiers() == [tier]
    end

    test "get_tier!/1 returns the tier with given id" do
      tier = tier_fixture()
      assert TIERS.get_tier!(tier.id) == tier
    end

    test "create_tier/1 with valid data creates a tier" do
      valid_attrs = %{description: "some description", max_cars: 42, name: "some name"}

      assert {:ok, %Tier{} = tier} = TIERS.create_tier(valid_attrs)
      assert tier.description == "some description"
      assert tier.max_cars == 42
      assert tier.name == "some name"
    end

    test "create_tier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TIERS.create_tier(@invalid_attrs)
    end

    test "update_tier/2 with valid data updates the tier" do
      tier = tier_fixture()
      update_attrs = %{description: "some updated description", max_cars: 43, name: "some updated name"}

      assert {:ok, %Tier{} = tier} = TIERS.update_tier(tier, update_attrs)
      assert tier.description == "some updated description"
      assert tier.max_cars == 43
      assert tier.name == "some updated name"
    end

    test "update_tier/2 with invalid data returns error changeset" do
      tier = tier_fixture()
      assert {:error, %Ecto.Changeset{}} = TIERS.update_tier(tier, @invalid_attrs)
      assert tier == TIERS.get_tier!(tier.id)
    end

    test "delete_tier/1 deletes the tier" do
      tier = tier_fixture()
      assert {:ok, %Tier{}} = TIERS.delete_tier(tier)
      assert_raise Ecto.NoResultsError, fn -> TIERS.get_tier!(tier.id) end
    end

    test "change_tier/1 returns a tier changeset" do
      tier = tier_fixture()
      assert %Ecto.Changeset{} = TIERS.change_tier(tier)
    end
  end
end
