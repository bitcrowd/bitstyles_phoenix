defmodule BitstylesPhoenix.BitstylesTest do
  use ExUnit.Case
  import BitstylesPhoenix.Bitstyles
  import ExUnit.CaptureIO

  describe "classname/2" do
    test "version 4.0.0" do
      assert Regex.match?(
               ~r/4.0.0 of bitstyles is not yet supported/,
               capture_io(:stderr, fn -> classname("u-flex", "4.0.0") end)
             )
    end

    test "version 3.0.0" do
      assert classname("u-flex", "3.0.0") == "u-flex"
      assert classname("u-flex-shrink-0", "3.0.0") == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", "3.0.0") == "u-flex-grow-1"
      assert classname("u-flex-wrap", "3.0.0") == "u-flex-wrap"
      assert classname("u-flex-col", "3.0.0") == "u-flex-col"
      assert classname("u-grid-cols-3", "3.0.0") == "u-grid-cols-3"
      assert classname("u-col-span-3", "3.0.0") == "u-col-span-3"
      assert classname("u-col-start-1", "3.0.0") == "u-col-start-1"
    end

    test "version 2.0.0" do
      assert classname("u-flex", "2.0.0") == "u-flex"
      assert classname("u-flex-shrink-0", "2.0.0") == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", "2.0.0") == "u-flex-grow-1"
      assert classname("u-flex-wrap", "2.0.0") == "u-flex-wrap"
      assert classname("u-flex-col", "2.0.0") == "u-flex-col"
      assert classname("u-grid-cols-3", "2.0.0") == "u-grid-cols-3"
      assert classname("u-col-span-3", "2.0.0") == "u-col-span-3"
      assert classname("u-col-start-1", "2.0.0") == "u-col-start-1"
    end

    test "version 1.5.0" do
      assert classname("u-flex", "1.5.0") == "u-flex"
      assert classname("u-flex-shrink-0", "1.5.0") == "u-flex__shrink-0"
      assert classname("u-flex-grow-1", "1.5.0") == "u-flex__grow-1"
      assert classname("u-flex-wrap", "1.5.0") == "u-flex--wrap"
      assert classname("u-flex-col", "1.5.0") == "u-flex--col"
      assert classname("u-grid-cols-3", "1.5.0") == "u-grid-cols-3"
      assert classname("u-col-span-3", "1.5.0") == "u-col-span-3"
      assert classname("u-col-start-1", "1.5.0") == "u-col-start-1"
    end

    test "version 1.3.0" do
      assert classname("u-flex", "1.3.0") == "u-flex"
      assert classname("u-flex-shrink-0", "1.3.0") == "u-flex__shrink-0"
      assert classname("u-flex-grow-1", "1.3.0") == "u-flex__grow-1"
      assert classname("u-flex-wrap", "1.3.0") == "u-flex--wrap"
      assert classname("u-flex-col", "1.3.0") == "u-flex--col"
      assert classname("u-grid-cols-3", "1.3.0") == "u-grid--3-col"
      assert classname("u-col-span-3", "1.3.0") == "u-grid__col-span-3"
      assert classname("u-col-start-1", "1.3.0") == "u-grid__col-1"
    end

    test "version < 1.3.0" do
      assert_raise(
        RuntimeError,
        ~r/version 1.1.0 of bitstyles is not supported/,
        fn -> classname("u-flex", "1.1.0") end
      )
    end
  end
end
