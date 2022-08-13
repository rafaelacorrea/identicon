defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """
  alias Identicon.Image

  def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
  end

  defp hash_input(input) do
    hex =
      :md5
      |> :crypto.hash(input)
      |> :binary.bin_to_list()

    %Image{hex: hex}
  end

  defp pick_color(%Image{hex: [r, g, b | _rest]} = image) do
    %Image{image | color: {r, g, b}}
  end

  defp mirror_row([frst, scnd | _rest] = row), do: row ++ [scnd, frst]

  defp build_grid(%Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index(&{&1, &2})

    %Image{image | grid: grid}
  end
end
