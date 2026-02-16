defmodule BitstylesPhoenixDemoWeb.PageController do
  alias BitstylesPhoenixDemo.Thing
  use BitstylesPhoenixDemoWeb, :controller

  plug :put_layout, {BitstylesPhoenixDemoWeb.LayoutView, :app}

  def index(conn, _params) do
    changeset =
      Thing.changeset(%{name: ""})
      |> Map.put(:action, "update")

    conn
    |> put_flash(:info, "Welcome to the Demo !!!")
    |> put_flash(:warning, "Let's pretend we have a warning.")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> put_view(BitstylesPhoenixDemoWeb.PageView)
    |> render("index.html", changeset: changeset)
  end
end
