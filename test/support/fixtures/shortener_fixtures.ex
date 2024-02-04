defmodule Hello.ShortenerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Shortener` context.
  """

  @doc """
  Generate a url.
  """
  def url_fixture(attrs \\ %{}) do
    {:ok, url} =
      attrs
      |> Enum.into(%{
        url: "some url"
      })
      |> Hello.Shortener.create_url()

    url
  end
end
