
defmodule SportMatchMakerWeb.OnboardingLive.ModalComponent do
  use SportMatchMakerWeb, :live_component

  alias SportMatchMaker.Accounts
  alias SportMatchMaker.Accounts.User

  @impl true
  def render(assigns) do
    ~H"""
      <div id={@id} class="mx-auto max-w-sm">
        <.header class="text-center">
          <%= gettext("Register for an account") %>
          <:subtitle>
            <%= gettext("Already registered?") %>
            <.link navigate={~p"/users/log_in"} class="font-semibold text-brand hover:underline">
              <%= gettext("Log in") %>
            </.link>
            <%= gettext("to your account now.") %>
          </:subtitle>
        </.header>

        <.simple_form
          for={@form}
          id="registration_form"
          phx-target={@myself}
          phx-submit="save"
          phx-change="validate"
          phx-trigger-action={@trigger_submit}
          action={~p"/users/log_in?_action=registered"}
          method="post"
        >
          <.error :if={@check_errors}>
            <%= gettext("Oops, something went wrong! Please check the errors below.") %>
          </.error>

          <.input field={@form[:email]} type="email" label={gettext("Email")} required />
          <.input field={@form[:password]} type="password" label={gettext("Password")} required />

          <:actions>
            <.button phx-disable-with="Creating account..." class="w-full bg-brand/80 hover:bg-brand/90">
              <%= gettext("Create an account") %>
            </.button>
          </:actions>
        </.simple_form>
      </div>
    """
  end

  @impl true
  def mount(socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket}
  end

  @impl true
  def update(assigns, socket) do
    {:ok, socket |> assign(assigns)}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    params = Map.put(user_params, "profile", socket.assigns.profile)

    case Accounts.register_user_with_profile(params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)
        {:noreply, socket |> assign(trigger_submit: true) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
