# Toolbelt

This is my **toolbelt** project.

# Contribution

Useful commands:

| Command                                      | Description         |
| -------------------------------------------- | ------------------- |
| `mix deps.get`                               | get dependencies    |
| `mix credo`                                  | style code analysis |
| `mix dialyzer`                               | BEAM code analysis  |
| `mix test --trace`                           | run tests           |
| `MIX_ENV=test mix coveralls.html --umbrella` | test coverage       |
| `mix docs`                                   | generate docs       |
| `MIX_ENV=prod mix escript.build`             | generate script     |

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `toolbelt` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:toolbelt, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/toolbelt](https://hexdocs.pm/toolbelt).
