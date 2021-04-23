defmodule BitstylesPhoenix.Time do
  import Phoenix.HTML, only: [sigil_E: 2]
  import BitstylesPhoenix.Showcase

  @moduledoc """
  Time-related UI components
  """

  @doc ~S"""
  Renders dates & times in a manner readable and expressive for both humans and machines.

  `human_time` — the string you want your human visitors to see
  `machine_time` — the UTC-formatted datetime string, with timezone.
  """

  story("A time", """
      iex> safe_to_string ui_time("15:17", "2020-11-10 14:17:32Z")
      ~s(<time datetime="2020-11-10 14:17:32Z" title="2020-11-10 14:17:32Z">15:17</time>)
  """)

  story("A date", """
      iex> safe_to_string ui_time("2020-11-18", "2020-11-18 14:23:14Z")
      ~s(<time datetime="2020-11-18 14:23:14Z" title="2020-11-18 14:23:14Z">2020-11-18</time>)
  """)

  def ui_time(human_time, machine_time) do
    ~E"<time datetime=\"<%= machine_time %>\" title=\"<%= machine_time %>\"><%= human_time %></time>"
  end
end
