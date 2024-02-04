defmodule HelloWeb.URLControllerTest do
  use HelloWeb.ConnCase

  import Hello.ShortenerFixtures

  @create_attrs %{url: "some url"}
  @update_attrs %{url: "some updated url"}
  @invalid_attrs %{url: nil}

  describe "index" do
    test "lists all url", %{conn: conn} do
      conn = get(conn, ~p"/url")
      assert html_response(conn, 200) =~ "Listing Url"
    end
  end

  describe "new url" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/url/new")
      assert html_response(conn, 200) =~ "New Url"
    end
  end

  describe "create url" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/url", url: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/url/#{id}"

      conn = get(conn, ~p"/url/#{id}")
      assert html_response(conn, 200) =~ "Url #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/url", url: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Url"
    end
  end

  describe "edit url" do
    setup [:create_url]

    test "renders form for editing chosen url", %{conn: conn, url: url} do
      conn = get(conn, ~p"/url/#{url}/edit")
      assert html_response(conn, 200) =~ "Edit Url"
    end
  end

  describe "update url" do
    setup [:create_url]

    test "redirects when data is valid", %{conn: conn, url: url} do
      conn = put(conn, ~p"/url/#{url}", url: @update_attrs)
      assert redirected_to(conn) == ~p"/url/#{url}"

      conn = get(conn, ~p"/url/#{url}")
      assert html_response(conn, 200) =~ "some updated url"
    end

    test "renders errors when data is invalid", %{conn: conn, url: url} do
      conn = put(conn, ~p"/url/#{url}", url: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Url"
    end
  end

  describe "delete url" do
    setup [:create_url]

    test "deletes chosen url", %{conn: conn, url: url} do
      conn = delete(conn, ~p"/url/#{url}")
      assert redirected_to(conn) == ~p"/url"

      assert_error_sent 404, fn ->
        get(conn, ~p"/url/#{url}")
      end
    end
  end

  defp create_url(_) do
    url = url_fixture()
    %{url: url}
  end
end
