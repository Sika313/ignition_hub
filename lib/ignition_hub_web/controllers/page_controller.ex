defmodule IgnitionHubWeb.PageController do
  use IgnitionHubWeb, :controller
  import Phoenix.LiveView.Controller
  alias IgnitionHub.USERS
  alias IgnitionHub.CLIENTS

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  
  def login(conn, _params) do
    render(conn, :login)
  end

  def handle_login(conn, params) do
    case USERS.find_by_phone_and_password(params) do
    {:error} ->
    case CLIENTS.find_by_phone_and_password(params) do
      {:ok, result} ->
        r = Map.from_struct(result)
        conn 
        |> put_flash(:info, "Logged in successfully.")
        |> put_session(:token, r.token)
        |> live_render(IgnitionHubWeb.ClientLive)
      {:error} ->
        conn 
        |> put_flash(:error, "Credentials incorrect.")
        |> redirect(to: "/login")
    end
    {:ok, result} ->
      conn
      |> put_flash(:info, "Admin found.")
      |> redirect("/")

    end
  end


end
