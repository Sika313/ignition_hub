defmodule IgnitionHubWeb.ClientLive do
  use IgnitionHubWeb, :live_view
  alias IgnitionHub.CLIENTS
  alias IgnitionHub.CARS
  alias IgnitionHub.SCHOOLS
  alias IgnitionHubWeb.ViewCarsComponent
  alias IgnitionHubWeb.ViewDrivingSchoolsComponent

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
        schools = SCHOOLS.list_schools()
        schools = for school <- schools do
          Map.from_struct(school)
        end
        socket = socket
        |> assign(:client, result_map)
        |> assign(:cars, cars)
        |> assign(:view_cars, false)
        |> assign(:schools, schools)
        |> assign(:view_driving_schools, false)
        {:ok, socket}
      nil ->
        socket = socket
        |> put_flash(:error, "You must login first.")
        |> redirect(to: "/")
        socket
    end
  end

  def handle_event("close_view_driving_schools", _params, socket) do
    socket = socket
    |> assign(:view_driving_schools, false)
    {:noreply, socket}
  end

  def handle_event("view_cars", _params, socket) do
    socket = socket
    |> assign(:view_cars, true)
    {:noreply, socket}
  end
  def handle_event("view_driving_schools", _params, socket) do
    socket = socket
    |> assign(:view_driving_schools, true)
    {:noreply, socket}
  end

  def handle_event("close", _params, socket) do
    socket = socket
    |> assign(:view_cars, false)
    {:noreply, socket}
  end

  def handle_event("handle_add_driving_school", params, socket) do
    driving_school = %{
      name: params["name"],
      location: params["location"],
      client_id: params["client_id"]
    }
    SCHOOLS.create_school(driving_school)
    schools = SCHOOLS.list_schools()
        schools = for school <- schools do
          Map.from_struct(school)
        end

    socket = socket
    |> put_flash(:info, "Driving School added successfully.")
    |> assign(:schools, schools)
    {:noreply, socket}
  end

end
