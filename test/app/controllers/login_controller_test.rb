require './app/controllers/login_controller'

class LoginControllerTest < Test::Unit::TestCase
  def test_show
    controller = LoginController.new
    response = controller.show

    assert response[:status] == 200
    assert response[:headers]['Content-Type'] == 'text/html'
  end
end
