defmodule IdenticonTest do
  use ExUnit.Case
  alias Identicon

  describe "main/1" do
    test "when a string value is passed, should return :ok" do
      image = Identicon.main("Olá")
      assert :ok == image
    end

    test "when a value different of string is passed, should return :error" do
      image = Identicon.main({"Olá"})
      {error, mensage} = image
      assert :error == error
      assert "insert a string valid value!" == mensage
    end
  end
end
