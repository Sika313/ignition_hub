defmodule IgnitionHubWeb.ClientLive do
  use IgnitionHubWeb, :live_view
  alias IgnitionHub.CLIENTS
  alias IgnitionHub.CARS
  alias IgnitionHubWeb.ViewCarsComponent

  def mount(_params, session, socket) do
    case CLIENTS.find_by_token(session["token"]) do
      {:ok, result} ->
        result_map = Map.from_struct(result)
        cars = case CARS.get_cars_by_client_id(result_map.id) do
          [] -> []
          results -> for result <- results do
            Map.from_struct(result)
          end
        end
        socket = socket
        |> assign(:client, result_map)
        |> assign(:cars, cars)
        |> assign(:view_cars, false)
        {:ok, socket}
      nil ->
        socket = socket
        |> put_flash(:error, "You must login first.")
        |> redirect(to: "/")
        socket
    end
  end

  def handle_event("view_cars", _params, socket) do
    socket = socket
    |> assign(:view_cars, true)
    {:noreply, socket}
  end

  def handle_event("close", _params, socket) do
    socket = socket
    |> assign(:view_cars, false)
    {:noreply, socket}
  end

end
