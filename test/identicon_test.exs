defmodule IdenticonTest do
  use ExUnit.Case
  alias Identicon

  describe "main/1" do
    test "when a string value is passed, should return :ok" do
      image = Identicon.main("Olá")
      assert :ok == image
    end
  end
end
