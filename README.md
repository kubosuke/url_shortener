# Hello

URL Shortener demo app

## Demo

https://url-shortener-kubosuke.fly.dev/

Or you can check capture from [Here](Demo.md)

## Entire architecture

![alt text](<docs_assets/url_shortener-Entire architecture.jpg>)

## Prerequired

* Redis Instance (fly.io, Redis Cloud etc)
* apikey of https://ipinfo.io/

## Run on your local

* Put your redis instance info in `application.ex`
* Put your ipinfo API key in `confix.exs`
* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deploy to fly.io

```
fly deploy
```

alternatively you can use CICD pipeline: [HowTo](.github/workflows/README.md)

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
