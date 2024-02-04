defmodule Hello.Shortener.URL do
  use Ecto.Schema
  import Ecto.Changeset

  schema "url" do
    field :url, :string
    field :hash, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end
