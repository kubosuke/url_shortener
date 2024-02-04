defmodule Hello.Worker do
  use GenServer

  require Logger

  alias Phoenix.PubSub
  alias Hello.Shortener

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(opts) do
    name = opts[:name]

    case PubSub.subscribe(Hello.PubSub, "register") do
      :ok -> Logger.info("🎉 Subsc OK")
      _error -> Logger.info("💥 Subsc NOT OK")
    end
    {:ok, %{name: name}}
  end

  def handle_info({:url, url}, state) do
    Shortener.create_url(url)
    {:noreply, state}
  end
end
