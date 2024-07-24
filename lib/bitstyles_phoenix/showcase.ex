defmodule BitstylesPhoenix.Showcase do
  @moduledoc false

  import Phoenix.Component, only: [sigil_H: 2]
  alias Phoenix.HTML.Safe

  defmacro story(name, doctest_iex_code, doctest_expected_results, opts \\ []) do
    default_version =
      BitstylesPhoenix.Bitstyles.default_version_string()
      |> String.to_atom()

    doctest_expected_results =
      if is_list(doctest_expected_results) && is_tuple(List.first(doctest_expected_results)) do
        doctest_expected_results
      else
        [{default_version, doctest_expected_results}]
      end

    doctest_expected_result_default_version =
      Keyword.get(doctest_expected_results, default_version)

    if doctest_expected_result_default_version == nil do
      raise """
      The third argument in the story/4 macro, the expected doctest result, must be a string.
      It could also be a keyword list of bitstyles versions to expected doctest result, with a required key of #{inspect(default_version)} (default version)
      """
    end

    code =
      doctest_expected_result_default_version
      |> to_string()
      |> String.split("\n")
      |> Enum.map_join("\n", &String.trim/1)

    storydoc = """
    ## #{name}

    #{sandbox(code, opts)}

    #{generate_doctests(doctest_iex_code, doctest_expected_results, default_version)}
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

    assigns = %{iframe_opts: iframe_opts}

    if dist do
      ~H"""
      <iframe {@iframe_opts} />
      """
    else
      ~H""
    end
    |> Safe.to_iodata()
    |> IO.iodata_to_binary()
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

  defp generate_doctests(doctest_iex_code, doctest_expected_results, default_version) do
    # it's crucial that there is exactly one new line after the iex code,
    # if there's more, it would be an always-green doctest without an expected result
    doctest_iex_code = doctest_iex_code |> to_string() |> String.trim_trailing()

    # when running unit tests, we want to test examples for all specified versions
    # when generating docs, we want to only to show the snippets for the default version
    if Mix.env() === :test do
      doctest_expected_results
      |> Enum.map_join("\n\n", fn {version, expected_result} ->
        """
            iex> Process.put(:bitstyles_phoenix_bistyles_version, "#{version}")
        #{doctest_iex_code |> String.replace("iex>", "...>")}
        #{expected_result}
        """
      end)
    else
      """
      #{doctest_iex_code}
      #{Keyword.get(doctest_expected_results, default_version)}

      """
    end
  end
end
