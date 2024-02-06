defmodule Hello.Shortener.VisitHistory do
  @key "visit_history"
  @conn_name :redix

  def set(name) do
    Redix.command(@conn_name, ["ZINCRBY", @key, 1, name])
  end

  def rank(name) do
    {:ok, res} = Redix.command(@conn_name, ["ZRANK", @key, name])

    res + 1
  end

  def list() do
    {:ok, res} = Redix.command(@conn_name, ["ZRANGE", @key, 0, -1, "WITHSCORES"])

    res
    |> Enum.chunk_every(2)
    |> Enum.with_index(1)
    |> Enum.map(fn {[name, score], rank} -> %{name: name, score: score, rank: rank} end)
  end
end
