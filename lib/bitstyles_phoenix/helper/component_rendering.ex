defmodule BitstylesPhoenix.Helper.ComponentRendering do
  @moduledoc false

  defmacro __using__(_) do
    quote do
      use BitstylesPhoenix, js_mode: :none
      alias Phoenix.HTML.Safe
      import Phoenix.Component, only: [sigil_H: 2]
      import Phoenix.HTML, only: [safe_to_string: 1]
      import BitstylesPhoenix.Helper.TestFixtures

      defp render(%Phoenix.LiveView.Rendered{} = template) do
        template
        |> Safe.to_iodata()
        |> IO.iodata_to_binary()
        |> prettify_html()
      end

      defp render(template) do
        template
        |> safe_to_string()
        |> prettify_html()
      end

      defp prettify_html(html) do
        html
        |> Floki.parse_fragment!()
        |> Floki.raw_html(pretty: true)
      end
    end
  end
end
