defmodule IgnitionHubWeb.ViewCarsComponent do
  use IgnitionHubWeb, :live_component

  def update(assigns, socket) do
    IO.inspect(assigns, label: "ASSIGNS---")
    socket = socket
    |> assign(:cars, assigns.cars)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <div>
        <button class="bg-blue-500 text-white" phx-click="close">Close</button>
    <ul class="flex flex-row justify-around">
    <%= for car <- @cars do %>
      <li>
      <img src={"/images/uploads/" <> car.pic_one} alt="Car" class="w-60 h-60"/>
      <p> Name: <%= car.make %> </p>
      <p> Price: <%= car.price %> </p>
      </li>
    <% end %>
    </ul>

      </div>

    """
  end

end
