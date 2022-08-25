# Identicon

## Installation
```bash
git clone https://github.com/rafaelacorrea/identicon

cd identicon

mix deps.get
```
## Run
In the identicon directory, execute the command:
```bash
iex -S mix
```
When the iex is activate, we add the command below to generate a identicon with inserted string:
```elixir
iex> Identicon.main("Shooky")
:ok
```
It will return a png:

<br>
  <img height="200" src=".github/Shooky.png" alt="Shooky.png">
  <br>