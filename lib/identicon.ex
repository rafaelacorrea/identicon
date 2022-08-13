defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """
  alias Identicon.Image

  def main(input) do
    input
    |> hash_input()
    |> pick_color()
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
end
