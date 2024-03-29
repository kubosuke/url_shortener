defmodule Hello.Visit.Worker do
  use GenServer

  require Logger

  alias Phoenix.PubSub
  alias Hello.Visit

  @country_code_to_continent %{
    "AF" => "Asia",
    "AL" => "Europe",
    "AQ" => "Antarctica",
    "DZ" => "Africa",
    "AS" => "Oceania",
    "AD" => "Europe",
    "AO" => "Africa",
    "AG" => "NorthAmerica",
    "AZ" => "Asia",
    "AR" => "SouthAmerica",
    "AU" => "Oceania",
    "AT" => "Europe",
    "BS" => "NorthAmerica",
    "BH" => "Asia",
    "BD" => "Asia",
    "AM" => "Asia",
    "BB" => "NorthAmerica",
    "BE" => "Europe",
    "BM" => "NorthAmerica",
    "BT" => "Asia",
    "BO" => "SouthAmerica",
    "BA" => "Europe",
    "BW" => "Africa",
    "BV" => "Antarctica",
    "BR" => "SouthAmerica",
    "BZ" => "NorthAmerica",
    "IO" => "Asia",
    "SB" => "Oceania",
    "VG" => "NorthAmerica",
    "BN" => "Asia",
    "BG" => "Europe",
    "MM" => "Asia",
    "BI" => "Africa",
    "BY" => "Europe",
    "KH" => "Asia",
    "CM" => "Africa",
    "CA" => "NorthAmerica",
    "CV" => "Africa",
    "KY" => "NorthAmerica",
    "CF" => "Africa",
    "LK" => "Asia",
    "TD" => "Africa",
    "CL" => "SouthAmerica",
    "CN" => "Asia",
    "TW" => "Asia",
    "CX" => "Asia",
    "CC" => "Asia",
    "CO" => "SouthAmerica",
    "KM" => "Africa",
    "YT" => "Africa",
    "CG" => "Africa",
    "CD" => "Africa",
    "CK" => "Oceania",
    "CR" => "NorthAmerica",
    "HR" => "Europe",
    "CU" => "NorthAmerica",
    "CY" => "Asia",
    "CZ" => "Europe",
    "BJ" => "Africa",
    "DK" => "Europe",
    "DM" => "NorthAmerica",
    "DO" => "NorthAmerica",
    "EC" => "SouthAmerica",
    "SV" => "NorthAmerica",
    "GQ" => "Africa",
    "ET" => "Africa",
    "ER" => "Africa",
    "EE" => "Europe",
    "FO" => "Europe",
    "FK" => "SouthAmerica",
    "GS" => "Antarctica",
    "FJ" => "Oceania",
    "FI" => "Europe",
    "AX" => "Europe",
    "FR" => "Europe",
    "GF" => "SouthAmerica",
    "PF" => "Oceania",
    "TF" => "Antarctica",
    "DJ" => "Africa",
    "GA" => "Africa",
    "GE" => "Asia",
    "GM" => "Africa",
    "PS" => "Asia",
    "DE" => "Europe",
    "GH" => "Africa",
    "GI" => "Europe",
    "KI" => "Oceania",
    "GR" => "Europe",
    "GL" => "NorthAmerica",
    "GD" => "NorthAmerica",
    "GP" => "NorthAmerica",
    "GU" => "Oceania",
    "GT" => "NorthAmerica",
    "GN" => "Africa",
    "GY" => "SouthAmerica",
    "HT" => "NorthAmerica",
    "HM" => "Antarctica",
    "VA" => "Europe",
    "HN" => "NorthAmerica",
    "HK" => "Asia",
    "HU" => "Europe",
    "IS" => "Europe",
    "IN" => "Asia",
    "ID" => "Asia",
    "IR" => "Asia",
    "IQ" => "Asia",
    "IE" => "Europe",
    "IL" => "Asia",
    "IT" => "Europe",
    "CI" => "Africa",
    "JM" => "NorthAmerica",
    "JP" => "Asia",
    "KZ" => "Asia",
    "JO" => "Asia",
    "KE" => "Africa",
    "KP" => "Asia",
    "KR" => "Asia",
    "KW" => "Asia",
    "KG" => "Asia",
    "LA" => "Asia",
    "LB" => "Asia",
    "LS" => "Africa",
    "LV" => "Europe",
    "LR" => "Africa",
    "LY" => "Africa",
    "LI" => "Europe",
    "LT" => "Europe",
    "LU" => "Europe",
    "MO" => "Asia",
    "MG" => "Africa",
    "MW" => "Africa",
    "MY" => "Asia",
    "MV" => "Asia",
    "ML" => "Africa",
    "MT" => "Europe",
    "MQ" => "NorthAmerica",
    "MR" => "Africa",
    "MU" => "Africa",
    "MX" => "NorthAmerica",
    "MC" => "Europe",
    "MN" => "Asia",
    "MD" => "Europe",
    "ME" => "Europe",
    "MS" => "NorthAmerica",
    "MA" => "Africa",
    "MZ" => "Africa",
    "OM" => "Asia",
    "NA" => "Africa",
    "NR" => "Oceania",
    "NP" => "Asia",
    "NL" => "Europe",
    "AN" => "NorthAmerica",
    "CW" => "NorthAmerica",
    "AW" => "NorthAmerica",
    "SX" => "NorthAmerica",
    "BQ" => "NorthAmerica",
    "NC" => "Oceania",
    "VU" => "Oceania",
    "NZ" => "Oceania",
    "NI" => "NorthAmerica",
    "NE" => "Africa",
    "NG" => "Africa",
    "NU" => "Oceania",
    "NF" => "Oceania",
    "NO" => "Europe",
    "MP" => "Oceania",
    "UM" => "NorthAmerica",
    "FM" => "Oceania",
    "MH" => "Oceania",
    "PW" => "Oceania",
    "PK" => "Asia",
    "PA" => "NorthAmerica",
    "PG" => "Oceania",
    "PY" => "SouthAmerica",
    "PE" => "SouthAmerica",
    "PH" => "Asia",
    "PN" => "Oceania",
    "PL" => "Europe",
    "PT" => "Europe",
    "GW" => "Africa",
    "TL" => "Asia",
    "PR" => "NorthAmerica",
    "QA" => "Asia",
    "RE" => "Africa",
    "RO" => "Europe",
    "RU" => "Asia",
    "RW" => "Africa",
    "BL" => "NorthAmerica",
    "SH" => "Africa",
    "KN" => "NorthAmerica",
    "AI" => "NorthAmerica",
    "LC" => "NorthAmerica",
    "MF" => "NorthAmerica",
    "PM" => "NorthAmerica",
    "VC" => "NorthAmerica",
    "SM" => "Europe",
    "ST" => "Africa",
    "SA" => "Asia",
    "SN" => "Africa",
    "RS" => "Europe",
    "SC" => "Africa",
    "SL" => "Africa",
    "SG" => "Asia",
    "SK" => "Europe",
    "VN" => "Asia",
    "SI" => "Europe",
    "SO" => "Africa",
    "ZA" => "Africa",
    "ZW" => "Africa",
    "ES" => "Europe",
    "SS" => "Africa",
    "EH" => "Africa",
    "SD" => "Africa",
    "SR" => "SouthAmerica",
    "SJ" => "Europe",
    "SZ" => "Africa",
    "SE" => "Europe",
    "CH" => "Europe",
    "SY" => "Asia",
    "TJ" => "Asia",
    "TH" => "Asia",
    "TG" => "Africa",
    "TK" => "Oceania",
    "TO" => "Oceania",
    "TT" => "NorthAmerica",
    "AE" => "Asia",
    "TN" => "Africa",
    "TR" => "Asia",
    "TM" => "Asia",
    "TC" => "NorthAmerica",
    "TV" => "Oceania",
    "UG" => "Africa",
    "UA" => "Europe",
    "MK" => "Europe",
    "EG" => "Africa",
    "GB" => "Europe",
    "GG" => "Europe",
    "JE" => "Europe",
    "IM" => "Europe",
    "TZ" => "Africa",
    "US" => "NorthAmerica",
    "VI" => "NorthAmerica",
    "BF" => "Africa",
    "UY" => "SouthAmerica",
    "UZ" => "Asia",
    "VE" => "SouthAmerica",
    "WF" => "Oceania",
    "WS" => "Oceania",
    "YE" => "Asia",
    "ZM" => "Africa",
    "XX" => "Oceania",
    "XE" => "Asia",
    "XD" => "Asia",
    "XS" => "Asia"
  }

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(opts) do
    name = opts[:name]

    PubSub.subscribe(Hello.PubSub, "visit")
    {:ok, %{name: name}}
  end

  def handle_info({:hash, hash, :ip, ip}, state) do
    Visit.set(hash, get_continent_from_ip(ip))
    {:noreply, state}
  end

  defp get_continent_from_ip(ip) do
    country_code =
      case GeoIP.lookup(ip) do
        {:ok, res} ->
          res[:country]

        _ ->
          nil
      end

    Map.get(@country_code_to_continent, country_code, "Unknown")
  end
end
