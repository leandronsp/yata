require './test/e2e/server_test_helper'

class HomePageTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_home
    request = <<~STR
      GET / HTTP/1.1\r\n
      \r\n\r\n
    STR

    server.puts(request)

    expected_response = <<~STR
      HTTP/1.1 200\r\n
      Content-Type: text/html\r\n
      \r\n
      <a href="/login">Login</a>
    STR

    assert_equal normalize_str(expected_response), response
  end
end
