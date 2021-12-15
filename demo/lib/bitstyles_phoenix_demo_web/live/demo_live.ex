defmodule BitstylesPhoenixDemoWeb.DemoLive do
  use BitstylesPhoenixDemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket

    {:ok, socket}
  end

  def handle_event("put_flash", _, socket) do
    socket =
      socket
      |> put_flash(:info, "Welcome to the Demo !!!")
      |> put_flash(:warning, "Let's pretend we have a warning.")
      |> put_flash(:error, "Let's pretend we have an error.")

    {:noreply, push_redirect(socket, to: "/live")}
  end
end
