class HomePageTest < Test::Unit::TestCase
  include ServerTestHelper
  include UserFactory
  include TaskFactory

  def test_home_guest
    server.puts(prepare_request("GET /"))

    assert remove_cr(response).match(/HTTP\/1\.1 200.*?Login.*?/)
  end

  def test_home_authenticated
    user = create_user!(email: 'test@acme.com')
    task = create_task!(user: user, name: 'My first task')

    server.puts(prepare_request("GET /",
                                "Cookie: email=test@acme.com"))

    expected_response = /HTTP\/1\.1 200.*?test@acme\.com.*?My first task.*?/
    assert remove_cr(response).match(expected_response)
  end

  def test_home_unauthorized
    FileUtils.rm('./db/users.txt')

    server.puts(prepare_request("GET /",
                                "Cookie: email=test@acme.com"))

    expected_response = /HTTP\/1\.1 301.*?Location:.*?\/login.*?/
    assert remove_cr(response).match(expected_response)
  end
end
