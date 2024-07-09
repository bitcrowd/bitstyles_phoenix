defmodule Scripts.GenerateVersionShowcase do
  import Phoenix.HTML, only: [safe_to_string: 1]
  import Phoenix.HTML.Tag, only: [content_tag: 3]

  @dir_name "version_showcase"

  @moduledoc "Generates static HTML pages in #{@dir_name} for manually testing bitstyles_phoenix with different bitstyles versions."

  @all_supported_bitstyles_versions [
    # do not use 5.0.0, it has an incorrect CSS build on the CDN
    "5.0.1",
    "4.3.0",
    "4.2.0",
    "4.1.0",
    "4.0.0",
    "3.1.0",
    "3.0.0",
    "2.0.0",
    "1.5.0",
    "1.4.0",
    "1.3.0"
  ]
  @doctest_entries ["iex>", "...>"]

  def run(args) do
    {opts, _} = OptionParser.parse!(args, strict: [only: :keep])
    only_versions = Keyword.get_values(opts, :only)
    components = get_components()

    versions =
      if only_versions == [] do
        @all_supported_bitstyles_versions
      else
        @all_supported_bitstyles_versions
        |> Enum.filter(&(&1 in only_versions))
      end

    File.mkdir_p(@dir_name)
    File.cp_r("assets", Path.join(@dir_name, "assets"))
    write_index_html(versions)

    IO.puts("Generating versions")

    versions
    |> Enum.each(fn version ->
      IO.puts(version)

      write_version_html(version, components)

      components
      |> Enum.map(fn component ->
        write_component_html(versions, version, component)
      end)
    end)

    IO.puts(IO.ANSI.green() <> "Done!" <> IO.ANSI.reset())
  end

  defp get_components() do
    "lib/bitstyles_phoenix/component/*.ex"
    |> Path.wildcard()
    |> Enum.map(fn path ->
      string = File.read!(path)
      ast = Code.string_to_quoted!(string)
      component_name = get_component_name(ast)
      stories = get_stories(ast)
      %{path: Path.expand(path), name: component_name, stories: stories}
    end)
  end

  defp get_component_name(ast) do
    {_, component_name} =
      Macro.prewalk(ast, nil, fn node, acc ->
        if acc do
          {node, acc}
        else
          # credo:disable-for-next-line Credo.Check.Refactor.Nesting
          case node do
            {:defmodule, _meta,
             [{:__aliases__, _, [:BitstylesPhoenix, :Component, component_name]}, _]} ->
              {node, component_name}

            _ ->
              {node, acc}
          end
        end
      end)

    component_name
  end

  defp get_stories(ast) do
    {_, stories} =
      Macro.prewalk(ast, [], fn node, acc ->
        case node do
          {:story, meta, args} ->
            name = Enum.at(args, 0)
            doctest_iex_code = Enum.at(args, 1)
            opts = Enum.at(args, 3)

            code =
              doctest_iex_code
              |> to_string()
              |> String.split("\n")
              |> Enum.map(&String.trim/1)
              |> Enum.map_join("\n", &extract_code_from_doctest_line/1)

            {node,
             [%{name: name, code: code, opts: opts || [], line: Keyword.get(meta, :line)} | acc]}

          _ ->
            {node, acc}
        end
      end)

    Enum.reverse(stories)
  end

  defp extract_code_from_doctest_line(line) do
    Enum.reduce(@doctest_entries, String.trim(line), &String.trim_leading(&2, &1))
  end

  defp write_index_html(versions) do
    path = Path.join(@dir_name, "index.html")
    title = "BitstylesPhoenix"

    versions_links =
      Enum.map(versions, fn version ->
        ~s(<li><a href="v#{slugify(version)}.html">#{version}</li>)
      end)

    body = """
    <h1>#{title}</h1>
    <h2>Bitstyles versions</h2>
    <ul>
    #{versions_links}
    </ul>
    """

    File.write!(path, html(title, body))
  end

  defp write_version_html(version, components) do
    path = Path.join(@dir_name, "v#{slugify(version)}.html")
    title = "BitstylesPhoenix with Bitstyles v#{version}"

    component_links =
      Enum.map(components, fn component ->
        ~s(<li><a href="v#{slugify(version)}/c#{component.name}.html">#{component.name}</li>)
      end)

    body = """
    <p><a href="./index.html">Back</versions>
    <h1>#{title}</h1>
    <h2>Components</h2>
    <ul>
    #{component_links}
    </ul>
    """

    File.write!(path, html(title, body))
  end

  defp write_component_html(versions, version, component) do
    dir_path = Path.join(@dir_name, "v#{slugify(version)}")
    File.mkdir_p(dir_path)
    path = Path.join(@dir_name, "v#{slugify(version)}/c#{component.name}.html")
    title = "Bitstyles v#{version} #{component.name}"

    stories =
      Enum.map(component.stories, fn story ->
        """
        <h3>#{story.name}</h3>
        #{render_story_with_version(component, story, version)}
        """
      end)

    body = """
    <p><a href="../v#{slugify(version)}.html">Back</a></p>
    <p>#{version_select(versions, version)}</p>
    <h1>BitstylesPhoenix with Bitstyles v#{version}</h1>
    <h2>#{component.name}</h2>
    #{stories}
    """

    File.write!(path, html(title, body))
  end

  defp html(title, body) do
    """
    <!DOCTYPE html>
    <html>
    <head>
      <title>#{title}</title>
      <style>
        *, *::before, *::after { box-sizing: border-box; }
        body { font-family: Helvetica Neue, Helvetica, Arial, sans-serif; }
      </style>
    </head>
    <body>
      #{body}
    </body>
    </html>
    """
  end

  defp slugify(string) do
    string
    |> String.replace(".", "_")
    |> String.replace(" ", "-")
  end

  defp render_story_with_version(component, story, version) do
    Application.put_env(:bitstyles_phoenix, :bitstyles_version, version)

    extra_html = Keyword.get(story.opts, :extra_html, "")
    transparent = Keyword.get(story.opts, :transparent, true)

    code = """
    defmodule BitstylesPhoenix.Component.#{component.name}.Showcase.V#{slugify(version)}.L#{story.line} do
      use BitstylesPhoenix.Helper.ComponentRendering
      use BitstylesPhoenix.Component

      def render_html do
        #{story.code}
      end
    end

    BitstylesPhoenix.Component.#{component.name}.Showcase.V#{slugify(version)}.L#{story.line}.render_html()
    """

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

    file_name = "#{slugify(story.name)}.html"
    relative_dir_path = "v#{slugify(version)}/c#{component.name}"
    full_dir_path = Path.join(@dir_name, relative_dir_path)
    full_file_path = Path.join(full_dir_path, file_name)
    iframe_src = "/#{relative_dir_path}/#{file_name}"

    iframe_srcdoc = ~s(<html lang="en"><head><title>#{iframe_src}</title><style>#{style}</style><link rel="stylesheet" href="#{dist}/build/bitstyles.css"></head><body>#{Enum.join([extra_html, result])}</body></html>)

    File.mkdir_p(full_dir_path)
    File.write!(full_file_path, iframe_srcdoc)

    iframe_opts =
      [
        src: iframe_src,
        style: "",
        allowtransparency: if(transparent, do: "true", else: "false")
      ]
      |> Keyword.merge(iframe_style_opts(story.opts))

    iframe =
      if dist do
        safe_to_string(content_tag(:iframe, "", iframe_opts))
      else
        ""
      end

    html_code = safe_to_string(content_tag(:code, result, []))

    """
    <h4>Source</h4>
    <pre>#{component.path}:#{story.line}</pre>
    <h4>Output</h4>
    <pre style="border: 1px solid lightgray;">#{html_code}</pre>
    <h4>Preview</h4>
    <div style="border: 1px solid lightgray; padding: 20px; margin-bottom: 60px">
    #{iframe}
    </div>
    """
  end

  @default_iframe_style """
    height:1px; \
    border:none; \
    overflow:hidden; \
    margin: 1em; \
  """

  defp iframe_style_opts(opts) do
    width = Keyword.get(opts, :width, "auto")

    Keyword.get(opts, :height)
    |> case do
      nil ->
        [
          style: "#{@default_iframe_style}width: #{width}",
          # https://stackoverflow.com/questions/819416/adjust-width-and-height-of-iframe-to-fit-with-content-in-it
          onload: """
          javascript:(function(o) { \
           o.style.height=(o.contentWindow.document.body.scrollHeight)+"px"; \
          }(this)); \
          """
        ]

      height ->
        [style: "#{@default_iframe_style}height: #{height}; width: #{width};"]
    end
  end

  defp version_select(versions, current_version) do
    options =
      versions
      |> Enum.map(fn version ->
        "<option #{if version == current_version, do: "selected=\"selected\""}>#{version}</option>"
      end)

    """

    <select onchange="document.location = document.location.href.replace('#{current_version}'.replace(/\\./g, '_'), event.target.value.replace(/\\./g, '_'))">
    #{options}
    </select>
    """
  end
end

Scripts.GenerateVersionShowcase.run(System.argv())
