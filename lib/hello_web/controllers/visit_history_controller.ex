defmodule HelloWeb.VisitHistoryController do
  use HelloWeb, :controller

  alias Hello.Shortener.VisitHistory

  def index(conn, _params) do
    visit_histories = VisitHistory.list()
    render(conn, :index, visit_histories: visit_histories)
  end
end
