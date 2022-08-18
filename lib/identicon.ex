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
    |> filter_odd_squares()
    |> build_pixel_map()
    |> draw_image()
    |> save_image(input)
  end

  defp hash_input(input) do
    hex =
      :md5
      |> :crypto.hash(input)
      |> :binary.bin_to_list()

    %Image{hex: hex}
  end

  defp pick_color(%Image{hex: [r, g, b | _rest]} = image), do: %Image{image | color: {r, g, b}}

  defp mirror_row([frst, scnd | _rest] = row), do: row ++ [scnd, frst]

  defp build_grid(%Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Image{image | grid: grid}
  end

  defp filter_odd_squares(%Image{grid: grid} = image) do
    grid = Enum.filter(grid, &(rem(elem(&1, 0), 2) == 0))

    %Image{image | grid: grid}
  end

  defp build_pixel_map(%Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_bin, index} ->
        hor = rem(index, 5) * 50
        ver = div(index, 5) * 50
        top_left = {hor, ver}
        bottom_right = {hor + 50, ver + 50}
        {top_left, bottom_right}
      end)

    %Image{image | pixel_map: pixel_map}
  end

  defp draw_image(%Image{color: color, pixel_map: pixel_map} = image) do
    imagem = :egd.create(250, 250)
    color = :egd.color(color)
    Enum.each(pixel_map, fn {x, y} -> :egd.filledRectangle(imagem, x, y, color) end)
    :egd.render(imagem)
  end

  defp save_image(imagem, input), do: File.write("#{input}.png", imagem)
end
