# CICD

## Environment

- Ubuntu: latest
- otp: ["26.0.0"]
- elixir: ["1.16.1"]
- postgres: 12

## Triggered by

push to `main` branch

## How does it work

1. Setup Elixir
2. Checkout code to `main`
3. Cache deps/compiled build
4. Install dependencies
5. Compile
6. Run test

=> If the test passed, deploy to https://url-shortener-kubosuke.fly.dev/

## How to update fly.io deploy token

```sh
fly tokens create deploy -x 999999h # Shorter is better in terms of security
```

Update secret in https://github.com/kubosuke/url_shortener/settings/secrets/actions