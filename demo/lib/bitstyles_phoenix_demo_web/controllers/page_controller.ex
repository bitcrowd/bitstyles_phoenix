defmodule BitstylesPhoenixDemoWeb.PageController do
  alias BitstylesPhoenixDemo.Thing
  use BitstylesPhoenixDemoWeb, :controller

  def index(conn, _params) do
    changeset =
      Thing.changeset()
      |> Map.put(:action, "update")

    conn
    |> put_flash(:info, "Welcome to the Demo !!!")
    |> put_flash(:warning, "Let's pretend we have a warning.")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render("index.html", changeset: changeset)
  end
end
