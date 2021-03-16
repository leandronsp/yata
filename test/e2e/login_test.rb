require 'bcrypt'
require './test/e2e/server_test_helper'

class LoginTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_login_form
    server.puts(prepare_request("GET /login"))

    assert remove_cr(response).match(/HTTP\/1\.1 200.*?/)
  end

  def test_post_login_success
    File.open('./db/users.txt', 'wb') do |file|
      file.puts("test@acme.com;#{BCrypt::Password.create('pass123')}")
    end

    server.puts(prepare_request("POST /login",
                                "Content-Length: 36",
                                "email=test@acme.com&password=pass123"))


    assert remove_cr(response).match(/HTTP\/1\.1 301.*?/)
  end

  def test_post_login_unauthorized
    server.puts(prepare_request("POST /login",
                                "Content-Length: 37",
                                "email=wrong@acme.com&password=pass123"))

    assert remove_cr(response).match(/HTTP\/1\.1 401.*?/)
  end
end
