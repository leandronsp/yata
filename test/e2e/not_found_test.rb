class NotFoundTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_path_not_found
    server.puts(prepare_request("GET /seumadruga"))

    assert remove_cr(response).match(/HTTP\/1\.1 404.*?/)
  end
end
