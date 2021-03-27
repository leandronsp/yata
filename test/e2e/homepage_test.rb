class HomePageTest < Test::Unit::TestCase
  include ServerTestHelper
  include UserFactory
  include TaskFactory

  def test_home_unauthenticated
    server.print(prepare_request("GET /"))

    expected_response = /HTTP\/1\.1 301.*?Location:.*?\/login.*?/
    assert remove_cr(response).match(expected_response)
  end

  def test_home_authenticated
    user = create_user!(email: 'test@acme.com')
    task = create_task!(user: user, name: 'My first task')

    server.print(prepare_request("GET /",
                                "Cookie: email=test@acme.com"))

    expected_response = /HTTP\/1\.1 200.*?test@acme\.com.*?My first task.*?/
    assert remove_cr(response).match(expected_response)
  end

  def test_home_unauthorized
    server.print(prepare_request("GET /",
                                "Cookie: email=unauthorized@acme.com"))

    expected_response = /HTTP\/1\.1 301.*?Location:.*?\/login.*?/
    assert remove_cr(response).match(expected_response)
  end
end
