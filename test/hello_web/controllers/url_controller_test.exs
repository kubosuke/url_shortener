defmodule HelloWeb.URLControllerTest do
  use HelloWeb.ConnCase

  import Hello.ShortenerFixtures

  describe "index" do
    test "redirect for no auth login: /url", %{conn: conn} do
      conn = get(conn, ~p"/url")
      assert html_response(conn, 302)
    end
  end

  describe "new url" do
    test "redirect for no auth login: /url/new", %{conn: conn} do
      conn = get(conn, ~p"/url/new")
      assert html_response(conn, 302)
    end
  end

  describe "edit url" do
    setup [:create_url]

    test "renders form for editing chosen url", %{conn: conn, url: url} do
      conn = get(conn, ~p"/url/#{url}/edit")
      assert html_response(conn, 302)
    end
  end

  defp create_url(_) do
    url = url_fixture()
    %{url: url}
  end
end
