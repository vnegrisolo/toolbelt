# Toolbelt

This is my **toolbelt** project.

# Contribution

Useful commands:

| Command        | Description         |
| -------------- | ------------------- |
| `mix deps.get` | Fetch dependencies  |
| `mix test`     | Run tests           |
| `mix docs`     | Generate docs       |
| `mix credo`    | Analyze code syntax |

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add `toolbelt` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:toolbelt, "~> 0.1.0"}]
end
```

2. Ensure `toolbelt` is started before your application:

```elixir
def application do
  [applications: [:toolbelt]]
end
```

