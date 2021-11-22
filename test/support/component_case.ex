defmodule BitstylesPhoenix.ComponentCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use BitstylesPhoenix, js_mode: :none
      import Phoenix.LiveView.Helpers, only: [sigil_H: 2]
      import Phoenix.HTML, only: [safe_to_string: 1]

      defp render(template = %Phoenix.LiveView.Rendered{}) do
        template
        |> Phoenix.HTML.Safe.to_iodata()
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
