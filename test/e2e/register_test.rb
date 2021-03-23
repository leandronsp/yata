class RegisterTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_register
    server.puts(prepare_request("GET /register"))

    assert remove_cr(response).match(/HTTP\/1\.1 200.*?/)
  end

  def test_post_register_success
    FileUtils.rm('./db/users.txt')

    server.puts(prepare_request("POST /register",
                                "Content-Length: 66",
                                "email=test@acme.com&password=pass123&password_confirmation=pass123"))

    assert remove_cr(response).match(/HTTP\/1\.1 301.*?/)
  end
end
