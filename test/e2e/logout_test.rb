require './app/services/password_hashing'
require './test/e2e/server_test_helper'

class LogoutTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_post_logout_success
    server.puts(prepare_request("POST /logout",
                                "Cookie: email=test@acme.com"))


    assert remove_cr(response).match(/HTTP\/1\.1 301.*?email=test@acme\.com.*?Expires=Thu, 01 Jan 1970.*?/)
  end
end
