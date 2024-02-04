defmodule HelloWeb.URLController do
  use HelloWeb, :controller

  alias Hello.Shortener
  alias Hello.Shortener.URL

  def index(conn, _params) do
    url = Shortener.list_url()
    render(conn, :index, url_collection: url)
  end

  def new(conn, _params) do
    changeset = Shortener.change_url(%URL{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"url" => url_params}) do
    case Shortener.create_url(url_params) do
      {:ok, url} ->
        conn
        |> put_flash(:info, "Url created successfully.")
        |> redirect(to: ~p"/url/#{url}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    url = Shortener.get_url!(id)
    render(conn, :show, url: url)
  end

  def edit(conn, %{"id" => id}) do
    url = Shortener.get_url!(id)
    changeset = Shortener.change_url(url)
    render(conn, :edit, url: url, changeset: changeset)
  end

  def update(conn, %{"id" => id, "url" => url_params}) do
    url = Shortener.get_url!(id)

    case Shortener.update_url(url, url_params) do
      {:ok, url} ->
        conn
        |> put_flash(:info, "Url updated successfully.")
        |> redirect(to: ~p"/url/#{url}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, url: url, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    url = Shortener.get_url!(id)
    {:ok, _url} = Shortener.delete_url(url)

    conn
    |> put_flash(:info, "Url deleted successfully.")
    |> redirect(to: ~p"/url")
  end
end
