class LogoutTest < Test::Unit::TestCase
  include ServerTestHelper
  include UserFactory

  def test_post_logout_success
    create_user!('test@acme.com')

    server.puts(prepare_request("POST /logout",
                                "Cookie: email=test@acme.com"))


    assert remove_cr(response).match(/HTTP\/1\.1 301.*?email=test@acme\.com.*?Expires=Thu, 01 Jan 1970.*?/)
  end
end
