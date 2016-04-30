ExUnit.start

Mix.Task.run "ecto.create", ~w(-r ElixirTwitter.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ElixirTwitter.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(ElixirTwitter.Repo)

