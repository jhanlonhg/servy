defmodule Servy.Api.BearController do
  alias Servy.Conv
  alias Servy.Wildthings
  alias Servy.Bear

  def index(%Conv{} = conv) do
    json =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)
      |> Poison.encode!()

      %{ conv | status: 200, resp_body: json, resp_content_type: "application/json" }
  end
end
