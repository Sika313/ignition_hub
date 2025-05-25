defmodule IgnitionHubWeb.ViewDrivingSchoolsComponent do
  use IgnitionHubWeb, :live_component

  def update(assigns, socket) do
    socket = socket
    |> assign(:schools, assigns.schools)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <div>
        <button class="bg-blue-500 text-white" phx-click="close_view_driving_schools">Close</button>
        <%= if @schools == [] do %>
          <h1> No schools found. </h1>
        <% else %>
          <div class="flex flex-row justify-around">
            <%= for school <- @schools do %>
            <div class="flex flex-col">
              <p> <%= school.name %> </p>
<iframe src={school.location} width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
            <% end %>
          </div>
        <% end %>
      </div>

    """
  end

end
