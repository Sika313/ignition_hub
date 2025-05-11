defmodule IgnitionHubWeb.PageController do
  use IgnitionHubWeb, :controller
  import Phoenix.LiveView.Controller
  alias IgnitionHub.USERS
  alias IgnitionHub.CLIENTS
  alias IgnitionHub.CARS
  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def search(conn, params) do
    IO.inspect(params, label: "PARAMS--->")
   cars = case CARS.search_car_by_name(params["search"]) do
    [] -> []

    results -> for result <- results do Map.from_struct(result) end
   end 
    conn = conn
    |> assign(:cars, cars)
    IO.inspect(cars, label: "CARS--->")
    render(conn, :search)
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
