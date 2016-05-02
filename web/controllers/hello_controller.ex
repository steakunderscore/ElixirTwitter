defmodule ElixirTwitter.HelloController do
  use ElixirTwitter.Web, :controller

  def index(conn, _params) do
    conn
    |> put_flash(:info, "Welcome to Phoenix, from flash info!")
    |> render("index.html")
  end

  def show(conn, %{"messenger" => messenger} = params) do
    render conn, "show.html", messenger: messenger
  end
end
