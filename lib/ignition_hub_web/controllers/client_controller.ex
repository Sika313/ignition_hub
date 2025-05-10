defmodule IgnitionHubWeb.ClientController do
  use IgnitionHubWeb, :controller
  import Phoenix.LiveView.Controller
  alias IgnitionHub.USERS
  alias IgnitionHub.CLIENTS

  def add_car(conn, params) do
    token = get_session(conn, :token)
    IO.inspect(token, label: "TOKEN--->")
    case CLIENTS.find_by_token(token) do
    
      {:ok, result} ->
        r = Map.from_struct(result)
        conn 
        |> put_session(:token, r.token)
        |> live_render(IgnitionHubWeb.AddCarLive)
      nil ->
        conn
        |> put_flash(:error, "You must login first")
        |> redirect(to: "/")
    end
  end

end
