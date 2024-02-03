defmodule ParserTest do
  use ExUnit.Case
  doctest Servy.Parser

  alias Servy.Parser

  test "parses a valid request body" do
    request = """
    POST /test HTTP/1.1\r
    Content-Type: application/x-www-form-urlencoded\r
    A: 1\r
    \r
    foo=bar&bat=baz
    """

    conv = Parser.parse(request)

    assert conv.method == "POST"
    assert conv.path == "/test"
    assert conv.params == %{"foo" => "bar", "bat" => "baz"}
    assert conv.headers == %{"Content-Type" => "application/x-www-form-urlencoded", "A" => "1" }
  end
end
