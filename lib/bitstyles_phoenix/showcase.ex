defmodule BitstylesPhoenix.Showcase do
  @moduledoc false

  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Tag, only: [content_tag: 3]

  @doctest_entries ["iex>", "...>"]

  defmacro story(name, example, opts \\ []) do
    code =
      example
      |> to_string()
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

    if Keyword.get(opts, :module, false) do
      quote do
        @moduledoc @moduledoc <> unquote(storydoc)
      end
    else
      quote do
        @doc @doc <> unquote(storydoc)
      end
    end
  end

  @default_iframe_style """
    height:1px; \
    border:none; \
    overflow:hidden; \
    padding-left: 1em; \
  """

  defp sandbox(code, opts) do
    extra_html = Keyword.get(opts, :extra_html, "")
    transparent = Keyword.get(opts, :transparent, true)
    {result, _} = Code.eval_string(code)
    dist = BitstylesPhoenix.Bitstyles.cdn_url()

    style =
      if transparent do
        """
        html{ \
          background-color: transparent !important; \
        } \
        \
        @media (prefers-color-scheme: dark) { \
          body {color: #fff; } \
        } \
        """
      else
        ""
      end

    iframe_opts =
      [
        srcdoc:
          ~s(<html><head><style>#{style}</style><link rel="stylesheet" href="#{dist}/build/bitstyles.css"></head><body>#{Enum.join([extra_html, result]) |> String.replace("\n", "")}</body></html>),
        style: "",
        allowtransparency: if(transparent, do: "true", else: "false")
      ]
      |> Keyword.merge(style_opts(opts))

    if dist do
      safe_to_string(content_tag(:iframe, "", iframe_opts))
    else
      ""
    end
  end

  defp style_opts(opts) do
    width = Keyword.get(opts, :width, "auto")

    Keyword.get(opts, :height)
    |> case do
      nil ->
        [
          style: "#{@default_iframe_style}width: #{width}",
          # https://stackoverflow.com/questions/819416/adjust-width-and-height-of-iframe-to-fit-with-content-in-it
          onload: """
            javascript:(function(o) { \
              o.style.height=(o.contentWindow.document.body.scrollHeight + 25)+"px"; \
            }(this)); \
          """
        ]

      height ->
        [style: "#{@default_iframe_style}height: #{height}; width: #{width};"]
    end
  end
end
