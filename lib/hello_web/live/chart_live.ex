defmodule HelloWeb.PageLive.Index do
  require Logger
  use HelloWeb, :live_view
  alias Hello.Visit

  @impl true
  def mount(_, _, socket) do
    # Log the assigned value
    socket = assign(socket, :hash, "hash")

    if connected?(socket) do
      :timer.send_interval(2000, self(), :update_chart)
    end

    {:ok, socket}
  end

  @impl true
  @spec handle_info(:update_chart, Phoenix.LiveView.Socket.t()) :: {:noreply, map()}
  def handle_info(:update_chart, socket) do
    socket = push_event(socket, "points", %{points: get_points_from_hash(socket.assigns.hash)})
    {:noreply, socket}
  end

  @impl true
  @spec handle_params(any(), binary(), Phoenix.LiveView.Socket.t()) :: {:noreply, map()}
  def handle_params(_, uri, socket) do
    hash =
      uri
      |> String.split("/")
      |> Enum.take(-1)

    socket = assign(socket, :hash, hash)
    {:noreply, socket}
  end

  defp get_points_from_hash(hash) do
    1..6 |> Enum.map(fn _ -> :rand.uniform(100) end)
    Visit.list(hash)
  end
end
