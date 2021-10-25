defmodule BitstylesPhoenix.ComponentCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Phoenix.LiveView.Helpers, only: [sigil_H: 2]

      defp render(template) do
        template
        |> Phoenix.HTML.Safe.to_iodata()
        |> IO.iodata_to_binary()
        |> Floki.parse_fragment!()
        |> Floki.raw_html(pretty: true)
      end
    end
  end
end
