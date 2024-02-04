defmodule Hello.Repo.Migrations.UrlExtendUrlLength do
  use Ecto.Migration

  def change do
    alter table("url") do
      modify :url, :string, size: 10000
    end
  end
end
