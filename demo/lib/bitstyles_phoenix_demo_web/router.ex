defmodule BitstylesPhoenixDemoWeb.Router do
  use BitstylesPhoenixDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BitstylesPhoenixDemoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", BitstylesPhoenixDemoWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/live", DemoLive
  end
end
