defmodule HelloWeb.RedirectController do
  use HelloWeb, :controller

  require Logger
  alias Hello.Shortener

  def index(conn, %{"hash" => hash}) do
    url = Shortener.get_url_by_hash!(hash)

    Phoenix.PubSub.broadcast(
      Hello.PubSub,
      "visit",
      {:hash, hash, :ip, parse_client_ip(conn)}
    )

    redirect(conn, external: url.url)
  end

  defp parse_client_ip(conn) do
    Plug.Conn.get_req_header(conn, "fly-client-ip")
    |> (fn l -> if(is_list(l), do: l, else: []) end).()
    |> List.last()
    |> (fn
          nil -> "127.0.0.1"
          x -> x
        end).()
  end
end
