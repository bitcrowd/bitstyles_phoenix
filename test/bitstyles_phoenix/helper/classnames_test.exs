defmodule BitstylesPhoenix.Helper.ClassnamesTest do
  use ExUnit.Case, async: true
  import BitstylesPhoenix.Helper.Classnames
  doctest BitstylesPhoenix.Helper.Classnames

  describe "classnames/1" do
    test "removes e2e- classes from class lists" do
      assert classnames("e2e-out o-in") == "o-in"
      assert classnames(["e2e-out o-in"]) == "o-in"
      assert classnames(["e2e-out o-#{"in"}"]) == "o-in"
      assert classnames([{"e2e-out o-in", true}]) == "o-in"
    end
  end
end
