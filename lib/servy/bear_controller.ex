defmodule Servy.BearController do
  alias Servy.Conv
  alias Servy.Wildthings
  alias Servy.Bear

  defp bear_line(%Bear{} = bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end

  def index(%Conv{} = conv) do
    items =
      Wildthings.list_bears()
      |> Enum.filter(&Bear.is_grizzly/1)
      |> Enum.sort(&Bear.order_asc_by_name/2)
      |> Enum.map(&bear_line/1)
      |> Enum.join()

    %{ conv | status: 200, resp_body: "<ul>#{items}</ul>" }
  end

  def show(%Conv{} = conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    %{ conv | status: 200, resp_body: "Bears #{bear.id}: #{bear.name}" }
  end
  def create(%Conv{} = conv, %{"type" => type, "name" => name}), do: %{ conv | status: 201, resp_body: "Create a #{type} bear named #{name}!"}
end
