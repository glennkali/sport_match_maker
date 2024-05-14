defmodule SportMatchMakerWeb.Card do
  use Phoenix.Component

  @moduledoc """
  Card component
  """

  attr(:title, :string, doc: "Card title")
  attr(:subheading, :string, doc: "Card subheading")
  attr(:body, :string, doc: "Card body")
  attr(:image, :string, doc: "Card image", required: false)

  attr(:class, :string, default: "", doc: "CSS class for card")
  attr(:rest, :global)
  slot :actions

  def card(assigns) do
    ~H"""
    <figure
      class={[
        "relative w-full overflow-hidden rounded-xl border p-4 transition-all",
        "bg-neutral-50-50 border-gray-200 text-zinc-500 hover:bg-neutral-100",
        "dark:border-gray-50 dark:bg-gray-50 dark:hover:bg-gray-50",
        @class
      ]}
      {@rest}
    >
      <div class="flex items-center justify-between gap-6">
        <div class="flex flex-row items-center gap-6">
          <img :if={assigns[:image]} class="rounded-full" width="64" height="64" alt="" src={@image} />
          <div class="flex flex-col">
            <figcaption class="text-lg font-medium text-black">
              <%= @title %>
            </figcaption>
            <p class="text-xs font-medium dark:text-zinc-700"><%= @subheading %></p>
          </div>
        </div>
        <div>
          <%= render_slot(@actions) %>
        </div>
      </div>
      <blockquote class="mt-6 text-sm"><%= @body %></blockquote>
    </figure>
    """
  end
end
