class RegisterThenLoginTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_register_then_login
    # Register
    FileUtils.rm('./db/users.txt')

    server.puts(prepare_request("POST /register",
                                "Content-Length: 66",
                                "email=test@acme.com&password=pass123&password_confirmation=pass123"))

    assert remove_cr(response).match(/HTTP\/1\.1 301.*?/)

    content = File.read('./db/users.txt')
    assert_equal 1, content.split("\n").size

    refresh!

    # Login
    server.puts(prepare_request("POST /login",
                                "Content-Length: 36",
                                "email=test@acme.com&password=pass123"))

    assert remove_cr(response).match(/HTTP\/1\.1 301.*?/)
  end
end
