require './test/e2e/server_test_helper'

class LoginTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_login_form
    request = <<~STR
      GET /login HTTP/1.1\r\n
      \r\n\r\n
    STR

    server.puts(request)

    assert response.match(/^HTTP\/1\.1\s200\r\n.*?/)
  end
end
