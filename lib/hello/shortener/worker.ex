defmodule Hello.Shortener.Worker do
  use GenServer

  require Logger

  alias Phoenix.PubSub
  alias Hello.Shortener

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(opts) do
    name = opts[:name]

    PubSub.subscribe(Hello.PubSub, "register")
    {:ok, %{name: name}}
  end

  def handle_info({:url, url}, state) do
    Shortener.create_url(url)
    {:noreply, state}
  end
end
