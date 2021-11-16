defmodule BitstylesPhoenixDemoWeb do
  @moduledoc false

  def controller do
    quote do
      use Phoenix.Controller, namespace: BitstylesPhoenixDemoWeb

      import Plug.Conn
      import BitstylesPhoenixDemoWeb.Gettext
      alias BitstylesPhoenixDemoWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/bitstyles_phoenix_demo_web/templates",
        namespace: BitstylesPhoenixDemoWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {BitstylesPhoenixDemoWeb.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import BitstylesPhoenixDemoWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
      use BitstylesPhoenix

      # Import LiveView and .heex helpers (live_render, live_patch, <.form>, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import BitstylesPhoenixDemoWeb.ErrorHelpers
      import BitstylesPhoenixDemoWeb.Gettext
      alias BitstylesPhoenixDemoWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
