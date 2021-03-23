class StatisAssetTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_css_asset
    server.puts(prepare_request("GET /public/yata.css"))

    assert remove_cr(response).match(/HTTP\/1\.1 200.*?/)
  end

  def test_asset_not_found
    server.puts(prepare_request("GET /public/wrooooong.css"))

    assert remove_cr(response).match(/HTTP\/1\.1 404.*?/)
  end
end
