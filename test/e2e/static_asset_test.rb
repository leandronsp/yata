class StatisAssetTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_css_asset
    server.print(prepare_request("GET /app/frontend/stylesheets/yata.css"))

    assert remove_cr(response).match(/HTTP\/1\.1 200.*?/)
  end

  def test_asset_not_found
    server.print(prepare_request("GET /app/frontend/stylesheets/wrooooong.css"))

    assert remove_cr(response).match(/HTTP\/1\.1 404.*?/)
  end
end
