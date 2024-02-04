defmodule Hello.ShortenerTest do
  use Hello.DataCase

  alias Hello.Shortener

  describe "url" do
    alias Hello.Shortener.URL

    import Hello.ShortenerFixtures

    @invalid_attrs %{url: nil}

    test "list_url/0 returns all url" do
      url = url_fixture()
      assert Shortener.list_url() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert Shortener.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      valid_attrs = %{url: "some url"}

      assert {:ok, %URL{} = url} = Shortener.create_url(valid_attrs)
      assert url.url == "some url"
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortener.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      update_attrs = %{url: "some updated url"}

      assert {:ok, %URL{} = url} = Shortener.update_url(url, update_attrs)
      assert url.url == "some updated url"
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortener.update_url(url, @invalid_attrs)
      assert url == Shortener.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %URL{}} = Shortener.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> Shortener.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = Shortener.change_url(url)
    end
  end
end
