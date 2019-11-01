# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveEvents.Repo.insert!(%LiveEvents.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
for i <- 1..100 do
  {:ok, _} =
    LiveEvents.Account.create_user(%{
      name: "User #{i}",
      email: "user#{i}@test",
      ph_number: 555555
    })
end

