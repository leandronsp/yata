require './app/controllers/hello_controller'

class HelloControllerTest < Test::Unit::TestCase
  def test_show
    controller = HelloController.new
    view_content = controller.show

    assert_equal "HTTP/1.1 200\r\n\r\nHello", view_content
  end
end
