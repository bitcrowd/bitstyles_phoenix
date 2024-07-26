defmodule BitstylesPhoenix.BitstylesTest do
  use ExUnit.Case
  import BitstylesPhoenix.Bitstyles
  import ExUnit.CaptureIO

  describe "classname/2" do
    test "version 6.0.0" do
      assert Regex.match?(
               ~r/6.0.0 of bitstyles is not yet supported/,
               capture_io(:stderr, fn -> classname("u-flex", {6, 0, 0}) end)
             )
    end

    # TODO: delete
    test "chained version" do
      assert classname("u-version-5-0-0", {5, 0, 1}) == "u-version-5-0-0"
      assert classname("u-version-5-0-0", {5, 0, 0}) == "u-version-5-0-0"
      assert classname("u-version-5-0-0", {4, 9, 0}) == "u-version-4"
      assert classname("u-version-5-0-0", {4, 4, 0}) == "u-version-4"
      assert classname("u-version-5-0-0", {4, 3, 0}) == "u-version-4"
      assert classname("u-version-5-0-0", {4, 2, 0}) == "u-version-4"
      assert classname("u-version-5-0-0", {4, 1, 0}) == "u-version-4"
      assert classname("u-version-5-0-0", {4, 0, 0}) == "u-version-4"
      assert classname("u-version-5-0-0", {3, 9, 9}) == "u-version-2"
      assert classname("u-version-5-0-0", {3, 0, 0}) == "u-version-2"
      assert classname("u-version-5-0-0", {2, 0, 0}) == "u-version-2"
      assert classname("u-version-5-0-0", {1, 6, 0}) == "u-version-1-5"
      assert classname("u-version-5-0-0", {1, 5, 0}) == "u-version-1-5"
      assert classname("u-version-5-0-0", {1, 4, 0}) == "u-version-1-3"
      assert classname("u-version-5-0-0", {1, 3, 0}) == "u-version-1-3"
    end

    test "version 5.0.0" do
      assert classname("u-flex", {5, 0, 0}) == "u-flex"
      assert classname("u-border-radius-0", {5, 0, 0}) == "u-border-radius-0"
      assert classname("u-overflow-x-auto", {5, 0, 0}) == "u-overflow-x-auto"
      assert classname("u-overflow-y-auto", {5, 0, 0}) == "u-overflow-y-auto"
      assert classname("u-bg-gray-80", {5, 0, 0}) == "u-bg-gray-80"
      assert classname("u-fg-warning", {5, 0, 0}) == "u-fg-warning"
      assert classname("u-font-medium", {5, 0, 0}) == "u-font-medium"
      assert classname("u-line-height-min", {5, 0, 0}) == "u-line-height-min"
      assert classname("u-text-right", {5, 0, 0}) == "u-text-right"
      assert classname("u-flex-shrink-0", {5, 0, 0}) == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", {5, 0, 0}) == "u-flex-grow-1"
      assert classname("u-flex-wrap", {5, 0, 0}) == "u-flex-wrap"
      assert classname("u-flex-col", {5, 0, 0}) == "u-flex-col"
      assert classname("u-grid-cols-3", {5, 0, 0}) == "u-grid-cols-3"
      assert classname("u-col-span-3", {5, 0, 0}) == "u-col-span-3"
      assert classname("u-col-start-1", {5, 0, 0}) == "u-col-start-1"
      assert classname("u-margin-2xs", {5, 0, 0}) == "u-margin-2xs"
      assert classname("u-margin-3xs\@m", {5, 0, 0}) == "u-margin-3xs\@m"
      assert classname("u-margin-3xs-bottom", {5, 0, 0}) == "u-margin-3xs-bottom"
      assert classname("u-padding-2xl", {5, 0, 0}) == "u-padding-2xl"
      assert classname("u-padding-3xl\@l", {5, 0, 0}) == "u-padding-3xl\@l"
      assert classname("u-margin-3xl-bottom", {5, 0, 0}) == "u-margin-3xl-bottom"
      assert classname("u-margin-neg-3xl-bottom", {5, 0, 0}) == "u-margin-neg-3xl-bottom"
      assert classname("u-list-none", {5, 0, 0}) == "u-list-none"
      assert classname("a-badge--text", {5, 0, 0}) == "a-badge--text"
      assert classname("u-fg-text", {5, 0, 0}) == "u-fg-text"
      assert classname("u-fg-text-darker", {5, 0, 0}) == "u-fg-text-darker"
      assert classname("u-bg-gray-darker", {5, 0, 0}) == "u-bg-gray-darker"
      assert classname("u-border-gray-light", {5, 0, 0}) == "u-border-gray-light"
      assert classname("u-border-gray-light-bottom", {5, 0, 0}) == "u-border-gray-light-bottom"
      assert classname("u-border-gray-dark", {5, 0, 0}) == "u-border-gray-dark"
    end

    test "version 4.3.0" do
      assert classname("u-flex", {4, 3, 0}) == "u-flex"
      assert classname("u-border-radius-0", {4, 3, 0}) == "u-border-radius-0"
      assert classname("u-overflow-x-auto", {4, 3, 0}) == "u-overflow-x-auto"
      assert classname("u-overflow-y-auto", {4, 3, 0}) == "u-overflow-y-auto"
      assert classname("u-bg-gray-80", {4, 3, 0}) == "u-bg-gray-80"
      assert classname("u-fg-warning", {4, 3, 0}) == "u-fg-warning"
      assert classname("u-font-medium", {4, 3, 0}) == "u-font-medium"
      assert classname("u-line-height-min", {4, 3, 0}) == "u-line-height-min"
      assert classname("u-text-right", {4, 3, 0}) == "u-text-right"
      assert classname("u-flex-shrink-0", {4, 3, 0}) == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", {4, 3, 0}) == "u-flex-grow-1"
      assert classname("u-flex-wrap", {4, 3, 0}) == "u-flex-wrap"
      assert classname("u-flex-col", {4, 3, 0}) == "u-flex-col"
      assert classname("u-grid-cols-3", {4, 3, 0}) == "u-grid-cols-3"
      assert classname("u-col-span-3", {4, 3, 0}) == "u-col-span-3"
      assert classname("u-col-start-1", {4, 3, 0}) == "u-col-start-1"
      assert classname("u-margin-2xs", {4, 3, 0}) == "u-margin-xxs"
      assert classname("u-margin-3xs\@m", {4, 3, 0}) == "u-margin-xxxs\@m"
      assert classname("u-margin-3xs-bottom", {4, 3, 0}) == "u-margin-xxxs-bottom"
      assert classname("u-padding-2xl", {4, 3, 0}) == "u-padding-xxl"
      assert classname("u-padding-3xl\@l", {4, 3, 0}) == "u-padding-xxxl\@l"
      assert classname("u-margin-3xl-bottom", {4, 3, 0}) == "u-margin-xxxl-bottom"
      assert classname("u-margin-neg-3xl-bottom", {4, 3, 0}) == "u-margin-neg-xxxl-bottom"
      assert classname("u-list-none", {4, 3, 0}) == "a-list-reset"
      assert classname("a-badge--text", {4, 3, 0}) == "a-badge--gray"
      assert classname("u-gap-l", {4, 3, 0}) == "u-gap-l"
      assert classname("u-fg-text", {4, 3, 0}) == "u-fg-gray-30"
      assert classname("u-fg-text-darker", {4, 3, 0}) == "u-fg-gray-50"
      assert classname("u-bg-gray-darker", {4, 3, 0}) == "u-bg-gray-80"
      assert classname("u-border-gray-light", {4, 3, 0}) == "u-border-gray-10"
      assert classname("u-border-gray-light-bottom", {4, 3, 0}) == "u-border-gray-10-bottom"
      assert classname("u-border-gray-dark", {4, 3, 0}) == "u-border-gray-70"
    end

    test "version 4.2.0" do
      assert classname("u-border-radius-0", {4, 2, 0}) == "u-border-radius-0"
    end

    test "version 4.1.0" do
      assert classname("u-flex", {4, 1, 0}) == "u-flex"
      assert classname("u-border-radius-0", {4, 1, 0}) == "u-round-0"
      assert classname("u-overflow-x-auto", {4, 1, 0}) == "u-overflow-x-auto"
      assert classname("u-overflow-y-auto", {4, 1, 0}) == "u-overflow-y-auto"
      assert classname("u-bg-gray-80", {4, 1, 0}) == "u-bg-gray-80"
      assert classname("u-fg-warning", {4, 1, 0}) == "u-fg-warning"
      assert classname("u-font-medium", {4, 1, 0}) == "u-font-medium"
      assert classname("u-line-height-min", {4, 1, 0}) == "u-line-height-min"
      assert classname("u-text-right", {4, 1, 0}) == "u-text-right"
      assert classname("u-flex-shrink-0", {4, 1, 0}) == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", {4, 1, 0}) == "u-flex-grow-1"
      assert classname("u-flex-wrap", {4, 1, 0}) == "u-flex-wrap"
      assert classname("u-flex-col", {4, 1, 0}) == "u-flex-col"
      assert classname("u-grid-cols-3", {4, 1, 0}) == "u-grid-cols-3"
      assert classname("u-col-span-3", {4, 1, 0}) == "u-col-span-3"
      assert classname("u-col-start-1", {4, 1, 0}) == "u-col-start-1"
    end

    test "version 4.0.0" do
      assert classname("u-flex", {4, 0, 0}) == "u-flex"
      assert classname("u-border-radius-0", {4, 0, 0}) == "u-round-0"
      assert classname("u-overflow-x-auto", {4, 0, 0}) == "u-overflow-x-auto"
      assert classname("u-overflow-y-auto", {4, 0, 0}) == "u-overflow-y-auto"
      assert classname("u-bg-gray-80", {4, 0, 0}) == "u-bg-gray-80"
      assert classname("u-fg-warning", {4, 0, 0}) == "u-fg-warning"
      assert classname("u-font-medium", {4, 0, 0}) == "u-font-medium"
      assert classname("u-line-height-min", {4, 0, 0}) == "u-line-height-min"
      assert classname("u-text-right", {4, 0, 0}) == "u-text-right"
      assert classname("u-flex-shrink-0", {4, 0, 0}) == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", {4, 0, 0}) == "u-flex-grow-1"
      assert classname("u-flex-wrap", {4, 0, 0}) == "u-flex-wrap"
      assert classname("u-flex-col", {4, 0, 0}) == "u-flex-col"
      assert classname("u-grid-cols-3", {4, 0, 0}) == "u-grid-cols-3"
      assert classname("u-col-span-3", {4, 0, 0}) == "u-col-span-3"
      assert classname("u-col-start-1", {4, 0, 0}) == "u-col-start-1"
    end

    test "version 3.0.0" do
      assert classname("u-flex", {3, 0, 0}) == "u-flex"
      assert classname("u-overflow-x-auto", {3, 0, 0}) == "u-overflow--x"
      assert classname("u-overflow-y-auto", {3, 0, 0}) == "u-overflow--y"
      assert classname("u-bg-gray-80", {3, 0, 0}) == "u-bg--gray-80"
      assert classname("u-fg-warning", {3, 0, 0}) == "u-fg--warning"
      assert classname("u-font-medium", {3, 0, 0}) == "u-font--medium"
      assert classname("u-line-height-min", {3, 0, 0}) == "u-line-height--min"
      assert classname("u-text-right", {3, 0, 0}) == "u-text--right"
      assert classname("u-round-0-tr", {3, 0, 0}) == "u-round--0-tr"
      assert classname("u-border-radius-0-tr", {3, 0, 0}) == "u-round--0-tr"
      assert classname("u-flex-shrink-0", {3, 0, 0}) == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", {3, 0, 0}) == "u-flex-grow-1"
      assert classname("u-flex-wrap", {3, 0, 0}) == "u-flex-wrap"
      assert classname("u-flex-col", {3, 0, 0}) == "u-flex-col"
      assert classname("u-grid-cols-3", {3, 0, 0}) == "u-grid-cols-3"
      assert classname("u-col-span-3", {3, 0, 0}) == "u-col-span-3"
      assert classname("u-col-start-1", {3, 0, 0}) == "u-col-start-1"

      # Support existing classes
      assert classname("u-bg--gray-80", {3, 0, 0}) == "u-bg--gray-80"
      assert classname("u-fg--warning", {3, 0, 0}) == "u-fg--warning"
      assert classname("u-font--medium", {3, 0, 0}) == "u-font--medium"
      assert classname("u-line-height--min", {3, 0, 0}) == "u-line-height--min"
      assert classname("u-text--right", {3, 0, 0}) == "u-text--right"
      assert classname("u-round--0-tr", {3, 0, 0}) == "u-round--0-tr"
    end

    test "version 2.0.0" do
      assert classname("u-flex", {2, 0, 0}) == "u-flex"
      assert classname("u-overflow-x-auto", {2, 0, 0}) == "u-overflow--x"
      assert classname("u-overflow-y-auto", {2, 0, 0}) == "u-overflow--y"
      assert classname("u-bg-gray-80", {2, 0, 0}) == "u-bg--gray-80"
      assert classname("u-fg-warning", {2, 0, 0}) == "u-fg--warning"
      assert classname("u-font-medium", {2, 0, 0}) == "u-font--medium"
      assert classname("u-line-height-min", {2, 0, 0}) == "u-line-height--min"
      assert classname("u-text-right", {2, 0, 0}) == "u-text--right"
      assert classname("u-border-radius-0-tr", {2, 0, 0}) == "u-round--0-tr"
      assert classname("u-flex-shrink-0", {2, 0, 0}) == "u-flex-shrink-0"
      assert classname("u-flex-grow-1", {2, 0, 0}) == "u-flex-grow-1"
      assert classname("u-flex-wrap", {2, 0, 0}) == "u-flex-wrap"
      assert classname("u-flex-col", {2, 0, 0}) == "u-flex-col"
      assert classname("u-grid-cols-3", {2, 0, 0}) == "u-grid-cols-3"
      assert classname("u-col-span-3", {2, 0, 0}) == "u-col-span-3"
      assert classname("u-col-start-1", {2, 0, 0}) == "u-col-start-1"
    end

    test "version 1.5.0" do
      assert classname("u-flex", {1, 5, 0}) == "u-flex"
      assert classname("u-overflow-x-auto", {1, 5, 0}) == "u-overflow--x"
      assert classname("u-overflow-y-auto", {1, 5, 0}) == "u-overflow--y"
      assert classname("u-bg-gray-80", {1, 5, 0}) == "u-bg--gray-80"
      assert classname("u-fg-warning", {1, 5, 0}) == "u-fg--warning"
      assert classname("u-font-medium", {1, 5, 0}) == "u-font--medium"
      assert classname("u-line-height-min", {1, 5, 0}) == "u-line-height--min"
      assert classname("u-text-right", {1, 5, 0}) == "u-text--right"
      assert classname("u-border-radius-0-tr", {1, 5, 0}) == "u-round--0-tr"
      assert classname("u-flex-shrink-0", {1, 5, 0}) == "u-flex__shrink-0"
      assert classname("u-flex-grow-1", {1, 5, 0}) == "u-flex__grow-1"
      assert classname("u-flex-wrap", {1, 5, 0}) == "u-flex--wrap"
      assert classname("u-flex-col", {1, 5, 0}) == "u-flex--col"
      assert classname("u-grid-cols-3", {1, 5, 0}) == "u-grid-cols-3"
      assert classname("u-col-span-3", {1, 5, 0}) == "u-col-span-3"
      assert classname("u-col-start-1", {1, 5, 0}) == "u-col-start-1"
    end

    test "version 1.3.0" do
      assert classname("u-flex", {1, 3, 0}) == "u-flex"
      assert classname("u-overflow-x-auto", {1, 3, 0}) == "u-overflow--x"
      assert classname("u-overflow-y-auto", {1, 3, 0}) == "u-overflow--y"
      assert classname("u-bg-gray-80", {1, 3, 0}) == "u-bg--gray-80"
      assert classname("u-fg-warning", {1, 3, 0}) == "u-fg--warning"
      assert classname("u-font-medium", {1, 3, 0}) == "u-font--medium"
      assert classname("u-line-height-min", {1, 3, 0}) == "u-line-height--min"
      assert classname("u-text-right", {1, 3, 0}) == "u-text--right"
      assert classname("u-border-radius-0-tr", {1, 3, 0}) == "u-round--0-tr"
      assert classname("u-flex-shrink-0", {1, 3, 0}) == "u-flex__shrink-0"
      assert classname("u-flex-grow-1", {1, 3, 0}) == "u-flex__grow-1"
      assert classname("u-flex-wrap", {1, 3, 0}) == "u-flex--wrap"
      assert classname("u-flex-col", {1, 3, 0}) == "u-flex--col"
      assert classname("u-grid-cols-3", {1, 3, 0}) == "u-grid--3-col"
      assert classname("u-col-span-3", {1, 3, 0}) == "u-grid__col-span-3"
      assert classname("u-col-start-1", {1, 3, 0}) == "u-grid__col-1"
    end

    test "version < 1.3.0" do
      assert_raise(
        RuntimeError,
        ~r/version 1.1.0 of bitstyles is not supported/,
        fn -> classname("u-flex", {1, 1, 0}) end
      )
    end

    test "requires a version tuple" do
      assert_raise(
        FunctionClauseError,
        fn -> classname("u-flex", "5.0.0") end
      )
    end
  end
end
