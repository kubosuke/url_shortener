defmodule Hello.Visit do
  require Logger

  @continents [
    "NorthAmerica",
    "Antarctica",
    "Asia",
    "Oceania",
    "Europe",
    "Africa",
    "SouthAmerica",
    "Unknown"
  ]
  @conn_name :redix

  def set(hash, continent) do
    Redix.command(@conn_name, ["INCR", "#{hash}:#{continent}"])
  end

  def list(hash) do
    Enum.map(@continents, fn continent ->
      case Redix.command(@conn_name, ["GET", "#{hash}:#{continent}"]) do
        {:ok, res} when res != nil ->
          case Integer.parse(res) do
            {num, _} -> num
            _ -> 0
          end

        _ ->
          0
      end
    end)
  end
end
