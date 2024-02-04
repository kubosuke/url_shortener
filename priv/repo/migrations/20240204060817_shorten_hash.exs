defmodule Hello.Repo.Migrations.ShortenHash do
  use Ecto.Migration

  def change do
    alter table("url") do
      modify :hash, :string, size: 256
    end
  end
end
