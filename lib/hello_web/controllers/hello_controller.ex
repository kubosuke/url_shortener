defmodule HelloWeb.RedirectController do
  use HelloWeb, :controller

  alias Hello.Shortener

  def index(conn, %{"hash" => hash}) do
    url = Shortener.get_url_by_hash!(hash)
    redirect(conn, external: url.url)
  end
end
