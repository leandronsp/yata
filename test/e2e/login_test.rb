class LoginTest < Test::Unit::TestCase
  include ServerTestHelper
  include UserFactory

  def test_login_form
    server.print(prepare_request("GET /login"))

    assert remove_cr(response).match(/HTTP\/1\.1 200.*?/)
  end

  def test_post_login_success
    create_user!(email: 'test@acme.com')

    server.print(prepare_request("POST /login",
                                "Content-Length: 36",
                                "email=test@acme.com&password=pass123"))

    assert remove_cr(response).match(/HTTP\/1\.1 301.*?/)
  end

  def test_post_login_unauthorized
    server.print(prepare_request("POST /login",
                                "Content-Length: 37",
                                "email=wrong@acme.com&password=pass123"))

    assert remove_cr(response).match(/HTTP\/1\.1 401.*?/)
  end
end
