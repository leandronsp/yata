class HomePageTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_home_guest
    server.puts(prepare_request("GET /"))

    assert remove_cr(response).match(/HTTP\/1\.1 200.*?Login.*?/)
  end

  def test_home_authenticated
    server.puts(prepare_request("GET /",
                                "Cookie: email=test@acme.com"))

    assert remove_cr(response).match(/HTTP\/1\.1 200.*?test@acme\.com.*?/)
  end
end
