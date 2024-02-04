defmodule Hello.Repo.Migrations.UrlAddHashColumn do
  use Ecto.Migration

  def change do
    alter table(:url) do
      add :hash, :string
    end
  end
end
