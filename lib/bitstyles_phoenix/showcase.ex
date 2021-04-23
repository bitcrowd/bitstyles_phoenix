defmodule BitstylesPhoenix.Showcase do
  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Tag, only: [content_tag: 3]

  @doctest_entries ["iex>", "...>"]

  defmacro story(name, example) do
    code =
      example
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.reject(fn line -> Enum.any?(@doctest_entries, &String.starts_with?(line, &1)) end)
      |> Enum.join("\n")

    storydoc = """
    ## #{name}

    #{sandbox(code)}

    #{example}
    """

    quote do
      @doc @doc <> unquote(storydoc)
    end
  end

  defp sandbox(code) do
    dist = Application.get_env(:bitstyles_phoenix, :bitstyles_dist)
    {result, _} = Code.eval_string(code)

    if dist do
      safe_to_string(
        content_tag(:iframe, "",
          srcdoc:
            ~s(<html style="background-color: transparent;"><head><link rel="stylesheet" href="#{
              dist
            }"></head><body>#{result}</body></html>),
          # https://stackoverflow.com/questions/819416/adjust-width-and-height-of-iframe-to-fit-with-content-in-it
          onload:
            "javascript:(function(o){o.style.height=o.contentWindow.document.body.scrollHeight+\"px\";}(this));",
          style: "height:1px;width:100%;border:none;overflow:hidden",
          allowtransparency: "true"
        )
      )
    else
      ""
    end
  end
end
