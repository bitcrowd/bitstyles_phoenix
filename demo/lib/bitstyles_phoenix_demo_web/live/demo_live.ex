defmodule BitstylesPhoenixDemoWeb.DemoLive do
  use BitstylesPhoenixDemoWeb, :live_view

  def handle_event("show-flash", _, socket) do
    socket =
      socket
      |> put_flash(:info, "Welcome to the Demo !!!")
      |> put_flash(:warning, "Let's pretend we have a warning.")
      |> put_flash(:error, "Let's pretend we have an error.")

    {:noreply, push_redirect(socket, to: "/live")}
  end
end
