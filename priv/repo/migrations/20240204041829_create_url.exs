defmodule Hello.Repo.Migrations.CreateUrl do
  use Ecto.Migration

  def change do
    create table(:url) do
      add :url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
