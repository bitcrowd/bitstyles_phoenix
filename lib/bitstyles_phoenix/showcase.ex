defmodule BitstylesPhoenix.Showcase do
  @moduledoc false

  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Tag, only: [content_tag: 3]

  @doctest_entries ["iex>", "...>"]

  defmacro story(name, example, opts \\ []) do
    code =
      example
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.reject(fn line -> Enum.any?(@doctest_entries, &String.starts_with?(line, &1)) end)
      |> Enum.join("\n")

    storydoc = """
    ## #{name}

    #{sandbox(code, opts)}

    #{example}
    """

    extra_html = Keyword.get(opts, :extra_html)

    storydoc =
      if extra_html && Keyword.get(opts, :show_extra_html, true) do
        storydoc <>
          """
          *Requires additional content on the page:*

          ```
          #{extra_html}
          ```
          """
      else
        storydoc
      end

    quote do
      @doc @doc <> unquote(storydoc)
    end
  end

  defp sandbox(code, opts) do
    extra_html = Keyword.get(opts, :extra_html, "")
    dist = Application.get_env(:bitstyles_phoenix, :bitstyles_dist)
    {result, _} = Code.eval_string(code)

    if dist do
      safe_to_string(
        content_tag(:iframe, "",
          srcdoc:
            ~s(<html style="background-color: transparent;"><head><style>@media (prefers-color-scheme: dark\){body{color: #fff;}}</style><link rel="stylesheet" href="#{
              dist
            }/build/bitstyles.css"></head><body>#{
              Enum.join([extra_html, result]) |> String.replace("\n", "")
            }</body></html>),
          # https://stackoverflow.com/questions/819416/adjust-width-and-height-of-iframe-to-fit-with-content-in-it
          onload:
            "javascript:(function(o){o.style.height=o.contentWindow.document.body.scrollHeight+\"px\";}(this));",
          style: "height:1px;width:100%;border:none;overflow:hidden;margin-left: 1em",
          allowtransparency: "true"
        )
      )
    else
      ""
    end
  end
end
