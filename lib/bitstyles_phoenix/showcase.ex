defmodule BitstylesPhoenix.Showcase do
  use BitstylesPhoenix.Components

  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Tag, only: [content_tag: 3]

  defmacro __using__(_) do
    quote do
      import BitstylesPhoenix.Showcase
      Module.register_attribute(__MODULE__, :showcase, accumulate: true)

      @before_compile BitstylesPhoenix.Showcase
    end
  end

  defmacro __before_compile__(_) do
    quote do
      @moduledoc """
      #{@moduledoc}
      #{@showcase |> Enum.reverse() |> Enum.join()}
      """
    end
  end

  defmacro showcase(name, code) do
    docs = """
    ### #{name}

        #{String.trim(code)}

    #{sandbox(code)}

    """

    quote do
      @showcase unquote(docs)
    end
  end

  defmacro showcase_section(name, ref) do
    docs = """
    ## #{name}

    See `BitstylesPhoenix.#{ref}`.
    """

    quote do
      @showcase unquote(docs)
    end
  end

  defp sandbox(component) do
    dist = Application.get_env(:bitstyles_phoenix, :bitstyles_dist)

    if dist do
      {result, _} = Code.eval_string(component, [], __ENV__)

      safe_to_string(
        content_tag(:iframe, "",
          srcdoc:
            ~s(<html style="background-color: transparent;"><head><link rel="stylesheet" href="#{
              dist
            }"></head><body >#{safe_to_string(result)}</body></html>),
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
