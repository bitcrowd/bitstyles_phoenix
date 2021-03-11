defmodule BitstylesPhoenix.ClassnamesTest do
  use ExUnit.Case, async: true
  import BitstylesPhoenix.Classnames
  doctest BitstylesPhoenix.Classnames

  describe "classnames/1" do
    test "removes e2e- classes from class lists" do
      assert classnames("e2e-out o-in") == "o-in"
      assert classnames(["e2e-out o-in"]) == "o-in"
      assert classnames(["e2e-out o-#{"in"}"]) == "o-in"
      assert classnames([{"e2e-out o-in", true}]) == "o-in"
    end
  end

  describe "xclassnames/1" do
    test "it removes e2e- classnames" do
      assert xclassnames("e2e-out o-in") == "o-in"
    end
  end
end
