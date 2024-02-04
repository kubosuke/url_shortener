defmodule Hello.Repo.Migrations.ExtendHash do
  use Ecto.Migration

  def change do
    alter table("url") do
      modify :hash, :string, size: 10000
    end
  end
end
