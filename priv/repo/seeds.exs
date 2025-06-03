# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     IgnitionHub.Repo.insert!(%IgnitionHub.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias IgnitionHub.USERS
alias IgnitionHub.TIERS

admin = %{
  fname: "Mashekwa",
  lname: "Sikatema",
  gender: "M",
  phone: "0779567086",
  password: "12345",
  token: UUID.uuid4(),
  tier_id: 1
}

tier = %{ name: "ADMIN", max_cars: 0, description: "SUPER USER"}

TIERS.create_tier(tier) |> then(fn i -> USERS.create_user(admin)  end)
