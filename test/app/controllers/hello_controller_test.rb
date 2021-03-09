require './app/controllers/hello_controller'

class HelloControllerTest < Test::Unit::TestCase
  def test_show
    controller = HelloController.new
    response = controller.show

    assert response[:status] = 200
    assert response[:body] = 'Hello'
  end
end
