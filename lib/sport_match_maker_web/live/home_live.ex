defmodule SportMatchMakerWeb.HomeLive do
  use SportMatchMakerWeb, :live_view

  import SportMatchMakerWeb.Card
  alias SportMatchMaker.Accounts
  alias SportMatchMaker.Accounts.User

  def render(assigns) do
    ~H"""
    <div id="home" class="w-full sm:w-auto">
      <.header>
        <span :if={@show_new}>
          <%= gettext("Active Members") %>
        </span>
        <span :if={!@show_new}>
          <%= gettext("Your Connections") %>
        </span>
        <:actions>
          <%= if @show_new do %>
            <.link patch={~p"/connections"}>
              <.icon name="hero-arrows-right-left" />
            </.link>
          <% end %>
          <%= if !@show_new do %>
            <.link patch={~p"/"}>
              <.icon name="hero-arrows-right-left" />
            </.link>
          <% end %>
        </:actions>
      </.header>
      <%= if @show_new do %>
        <div
          id="unmatched_users"
          phx-update="stream"
          phx-hook="Sortable"
        >
          <div
            :for={{id, user} <- @streams.unmatched_users}
            id={id}
            data-id={user.id}
            class="py-2 rounded-lg"
          >
            <.card image={"https://picsum.photos/id/#{user.id}/64"}
                   title={user.email} subheading={user.profile.skill_level}
                   body={"#{gettext("Lives in")} #{user.profile.borough} #{gettext("and is available")} #{Calendar.strftime(user.profile.game_time_preference, "%Y-%m-%d %H:%M:%S")}"}>
              <:actions>
                <.link patch={~p"/users/#{user.id}/match"}>
                  <.button class="bg-brand/80 hover:bg-brand/90">
                    <%= gettext("Connect") %>
                  </.button>
                </.link>
              </:actions>
            </.card>
          </div>
        </div>
      <% end %>
      <%= if !@show_new do %>
        <div
          id="matched_users"
        >
          <div
            :for={{id, user} <- @streams.matched_users}
            id={id}
            data-id={user.id}
            class="py-2 rounded-lg"
          >
            <.card image={"https://picsum.photos/id/#{user.id}/64"}
              title={user.email} subheading={user.profile.skill_level}
              body={"#{gettext("Lives in")} #{user.profile.borough} #{gettext("and is looking for")} #{user.profile.game_format_preference} #{gettext("games in")} #{user.profile.game_style_preference} #{gettext("modes at")} #{Calendar.strftime(user.profile.game_time_preference, "%Y-%m-%d %H:%M:%S")}"}
              class="relative w-full overflow-hidden rounded-xl border p-4 transition-all bg-teal-50-50 border-black-200 text-zinc-500 hover:bg-teal-100 dark:border-black-50 dark:bg-teal-50 dark:hover:bg-teal-50">
            </.card>
          </div>
        </div>
      <% end %>
    </div>
    <.modal
      :if={@live_action in [:new_match]}
      id="match-modal"
      show
      on_cancel={JS.patch(~p"/home")}
    >
      <.live_component
        scope={@scope}
        module={SportMatchMakerWeb.MatchLive.ModalComponent}
        id={@user.id}
        title={@page_title}
        action={@live_action}
        user={@user}
        patch={~p"/connections"}
      />
    </.modal>
    """
  end

  def mount(_params, _session, socket) do
    {unmatched_users, _matched_users} = User.active_users(socket.assigns.scope, 20)

    {:ok,
     socket
     |> assign(show_new: true)
     |> stream(:unmatched_users, unmatched_users)}
  end

  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, gettext("Home"))
    |> assign(show_new: true)
  end

  defp apply_action(socket, :index_connections, _params) do
    {_unmatched_users, matched_users} = User.active_users(socket.assigns.scope, 20)

    socket
    |> assign(:page_title, gettext("Connections"))
    |> assign(show_new: false)
    |> stream(:matched_users, matched_users)
  end

  defp apply_action(socket, :new_match, params) do
    socket
    |> assign(:page_title, gettext("New Match"))
    |> assign(user: Accounts.get_user!(params["id"]))
  end
end
