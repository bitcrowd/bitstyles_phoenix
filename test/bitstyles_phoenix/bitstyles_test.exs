defmodule BitstylesPhoenix.BitstylesTest do
  use ExUnit.Case
  import BitstylesPhoenix.Bitstyles
  import ExUnit.CaptureIO

  describe "classname/2" do
    test "version 5.0.0" do
      assert Regex.match?(
               ~r/5.0.0 of bitstyles is not yet supported/,
               capture_io(:stderr, fn -> classname("u-flex", "5.0.0") end)
             )
    end

    test "version 4.2.0" do
      assert classname("u-border-radius-0", "4.2.0") == "u-border-radius-0"
    end

    test "version 4.1.0" do
      assert classname("u-flex", "4.1.0") == "u-flex"
      assert classname("u-border-radius-0", "4.1.0") == "u-round-0"
      assert classname("u-overflow-x-auto", "4.1.0") == "u-overflow-x-auto"
      assert classname("u-overflow-y-auto", "4.1.0") == "u-overflow-y-auto"
      assert classname("u-bg-gray-80", "4.1.0") == "u-bg-gray-80"
      assert classname("u-fg-warning", "4.1.0") == "u-fg-warning"
      assert classname("u-font-medium", "4.1.0") == "u-font-medium"
      assert classname("u-line-height-min", "4.1.0") == "u-line-height-min"
      assert classname("u-text-right", "4.1.0") == "u-text-right"
      assert classname("u-flex-shrink-0", "4.1.0") == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", "4.1.0") == "u-flex-grow-1"
      assert classname("u-flex-wrap", "4.1.0") == "u-flex-wrap"
      assert classname("u-flex-col", "4.1.0") == "u-flex-col"
      assert classname("u-grid-cols-3", "4.1.0") == "u-grid-cols-3"
      assert classname("u-col-span-3", "4.1.0") == "u-col-span-3"
      assert classname("u-col-start-1", "4.1.0") == "u-col-start-1"
    end

    test "version 4.0.0" do
      assert classname("u-flex", "4.0.0") == "u-flex"
      assert classname("u-border-radius-0", "4.0.0") == "u-round-0"
      assert classname("u-overflow-x-auto", "4.0.0") == "u-overflow-x-auto"
      assert classname("u-overflow-y-auto", "4.0.0") == "u-overflow-y-auto"
      assert classname("u-bg-gray-80", "4.0.0") == "u-bg-gray-80"
      assert classname("u-fg-warning", "4.0.0") == "u-fg-warning"
      assert classname("u-font-medium", "4.0.0") == "u-font-medium"
      assert classname("u-line-height-min", "4.0.0") == "u-line-height-min"
      assert classname("u-text-right", "4.0.0") == "u-text-right"
      assert classname("u-flex-shrink-0", "4.0.0") == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", "4.0.0") == "u-flex-grow-1"
      assert classname("u-flex-wrap", "4.0.0") == "u-flex-wrap"
      assert classname("u-flex-col", "4.0.0") == "u-flex-col"
      assert classname("u-grid-cols-3", "4.0.0") == "u-grid-cols-3"
      assert classname("u-col-span-3", "4.0.0") == "u-col-span-3"
      assert classname("u-col-start-1", "4.0.0") == "u-col-start-1"
    end

    test "version 3.0.0" do
      assert classname("u-flex", "3.0.0") == "u-flex"
      assert classname("u-overflow-x-auto", "3.0.0") == "u-overflow--x"
      assert classname("u-overflow-y-auto", "3.0.0") == "u-overflow--y"
      assert classname("u-bg-gray-80", "3.0.0") == "u-bg--gray-80"
      assert classname("u-fg-warning", "3.0.0") == "u-fg--warning"
      assert classname("u-font-medium", "3.0.0") == "u-font--medium"
      assert classname("u-line-height-min", "3.0.0") == "u-line-height--min"
      assert classname("u-text-right", "3.0.0") == "u-text--right"
      assert classname("u-border-radius-0-tr", "3.0.0") == "u-round--0-tr"
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
      assert classname("u-overflow-x-auto", "2.0.0") == "u-overflow--x"
      assert classname("u-overflow-y-auto", "2.0.0") == "u-overflow--y"
      assert classname("u-bg-gray-80", "2.0.0") == "u-bg--gray-80"
      assert classname("u-fg-warning", "2.0.0") == "u-fg--warning"
      assert classname("u-font-medium", "2.0.0") == "u-font--medium"
      assert classname("u-line-height-min", "2.0.0") == "u-line-height--min"
      assert classname("u-text-right", "2.0.0") == "u-text--right"
      assert classname("u-border-radius-0-tr", "2.0.0") == "u-round--0-tr"
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
      assert classname("u-overflow-x-auto", "1.5.0") == "u-overflow--x"
      assert classname("u-overflow-y-auto", "1.5.0") == "u-overflow--y"
      assert classname("u-bg-gray-80", "1.5.0") == "u-bg--gray-80"
      assert classname("u-fg-warning", "1.5.0") == "u-fg--warning"
      assert classname("u-font-medium", "1.5.0") == "u-font--medium"
      assert classname("u-line-height-min", "1.5.0") == "u-line-height--min"
      assert classname("u-text-right", "1.5.0") == "u-text--right"
      assert classname("u-border-radius-0-tr", "1.5.0") == "u-round--0-tr"
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
      assert classname("u-overflow-x-auto", "1.3.0") == "u-overflow--x"
      assert classname("u-overflow-y-auto", "1.3.0") == "u-overflow--y"
      assert classname("u-bg-gray-80", "1.3.0") == "u-bg--gray-80"
      assert classname("u-fg-warning", "1.3.0") == "u-fg--warning"
      assert classname("u-font-medium", "1.3.0") == "u-font--medium"
      assert classname("u-line-height-min", "1.3.0") == "u-line-height--min"
      assert classname("u-text-right", "1.3.0") == "u-text--right"
      assert classname("u-border-radius-0-tr", "1.3.0") == "u-round--0-tr"
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
