defmodule IgnitionHubWeb.SearchLive do
  use IgnitionHubWeb, :live_view
  alias IgnitionHub.CARS
  alias IgnitionHub.CLIENTS

  def mount(_params, session, socket) do
    cars = case CARS.list_cars() do
      [] -> []
      results -> for result <- results do Map.from_struct(result) end
    end
    IO.inspect(cars, label: "CARS--->")
    socket = socket
    |> assign(:cars, cars)
    |> assign(:model_results, " ")
    |> assign(:result_model, [])
    |> assign(:show_results, false)
    |> assign(:view_car, [])
    |> assign(:car_owner, %{})

    {:ok, socket}
  end

  def handle_event("select_model", params, socket) do
    IO.inspect(params, label: "PARAMS--->")
    cars = CARS.get_cars_by_model(params["value"])
    cars_map = for car <- cars do Map.from_struct(car) end
    IO.inspect(cars_map, label: "CARS MAP--->")
    socket = socket
    |> assign(:model, params["value"])
    |> assign(:model_results, cars_map)
    |> assign(:show_results, true)
    |> assign(:view_car, [])
    {:noreply, socket}
  end

  def handle_event("view_car", params, socket) do
    IO.inspect(params, label: "VIEW CAR--->")
    car = Enum.filter(socket.assigns.model_results, fn x -> x.id == String.to_integer(params["car_id"])  end)
    client_id = Enum.at(car, 0) 
    car_owner = CLIENTS.get_client!(client_id.client_id) |> Map.from_struct()
    socket = socket
    |> assign(:view_car, car)
    |> assign(:car_owner, car_owner)
    {:noreply, socket}
  end

end
