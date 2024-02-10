# Objective 5: Operational and Security Considerations

## Scalability solutions for handling peak loads.

- Peak loads for HTTP handler => Use cache (CDN, in-memory, kvs etc) for read requests.
- Peak loads caused by malicious/undesired requests => Apply rate control on frontend / cdn / WAF / app side.
- Peak loads for shorten url (/goto/) endpoint => Divide apps into admin handler (CRUD shorten url) and redirect handler (handle /goto/ redirection) and scale the latter one.
<!-- - `App` Use external broker (Redis, MQRabbit, kafka etc) and setup other worker that handle shorten url registration. -->
- Peak loads for CRUD visit data from Redis => Instead of using redis for visualize user metrics, integrate access logs to ELK, GCP etc and visualize in it (Grafana, Kibana, Cloud services etc).
- Peak loads for Postgres Write => Do bulk insertion - Flush shorten url creation request every N requests or every N seconds etc. .
- Peak loads for Postgres Read => Apply appropriate index.
- `DB` Cache query results from postgres to in-memory or in Redis etc.

## Cost-effective strategies for performance maintenance.

- In-memory cache results in redis.
- Remove unnecesary logs.
- Use appropriate index for postgres.
- Decrase the update rate of LiveView (fly.io claim costs for outbound network traffic: https://fly.io/docs/about/pricing/#network-prices)

##  Robust security practices to safeguard data and prevent unauthorized actions.

- Shorten URL creation => validation submitted URL in frontend(js), backend(elixir) before store in DB
- Apply appropriate session expiry
- Use strond hash algorithm for the password
- Don't hard code cookie sault (hardcoded by default: https://github.com/kubosuke/url_shortener/blob/809add8ad6e2f2eb71d4ed46a658381c061a7d17/lib/hello_web/endpoint.ex#L10 )
