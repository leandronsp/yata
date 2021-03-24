class RegisterThenLoginTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_register_then_login
    # Register

    server.puts(prepare_request("POST /register",
                                "Content-Length: 66",
                                "email=test@acme.com&password=pass123&password_confirmation=pass123"))

    assert remove_cr(response).match(/HTTP\/1\.1 301.*?Location: http:\/\/localhost:4242\/login/)

    refresh!

    # Login
    server.puts(prepare_request("POST /login",
                                "Content-Length: 36",
                                "email=test@acme.com&password=pass123"))

    assert remove_cr(response).match(/HTTP\/1\.1 301.*?Location: http:\/\/localhost:4242\//)
  end
end
