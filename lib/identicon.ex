defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """
  alias Identicon.Image

  def main(input) do
    hash_input(input)
  end

  defp hash_input(input) do
    hex =
      :md5
      |> :crypto.hash(input)
      |> :binary.bin_to_list()

    %Image{hex: hex}
  end
end
