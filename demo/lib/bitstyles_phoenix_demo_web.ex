defmodule BitstylesPhoenixDemoWeb do
  @moduledoc false

  def controller do
    quote do
      use Phoenix.Controller, formats: [:html]

      import Plug.Conn
      use Gettext, backend: BitstylesPhoenixDemoWeb.Gettext
      alias BitstylesPhoenixDemoWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/bitstyles_phoenix_demo_web/templates",
        namespace: BitstylesPhoenixDemoWeb,
        pattern: "**/*"

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      use BitstylesPhoenix.Alpine3

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {BitstylesPhoenixDemoWeb.LayoutView, :live}

      use BitstylesPhoenix.Live

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      use BitstylesPhoenix.Live

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
      use Gettext, backend: BitstylesPhoenixDemoWeb.Gettext
    end
  end

  defp view_helpers do
    quote do
      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View
      import Phoenix.Component
      # Use all HTML functionality (forms, tags, etc)
      import Phoenix.HTML
      import Phoenix.HTML.Form

      use BitstylesPhoenix
      # Import LiveView and .heex helpers (live_render, live_patch, <.form>, etc)

      import BitstylesPhoenixDemoWeb.ErrorHelpers
      use Gettext, backend: BitstylesPhoenixDemoWeb.Gettext
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
