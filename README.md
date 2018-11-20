# Personnummer
Validate Swedish social security numbers.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `personnummer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:personnummer, "~> 0.1.0"}
  ]
end
```

## Example

```elixir
iex> Personnummer.valid?(6403273813)
true
iex> Personnummer.valid?("19130401+2931")
true
```


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/personnummer](https://hexdocs.pm/personnummer).

