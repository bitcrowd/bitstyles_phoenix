defmodule BitstylesPhoenixDemoWeb.PageController do
  alias BitstylesPhoenixDemo.Thing
  use BitstylesPhoenixDemoWeb, :controller

  def index(conn, _params) do
    changeset =
      Thing.changeset()
      |> Map.put(:action, "update")

    render(conn, "index.html", changeset: changeset)
  end
end
