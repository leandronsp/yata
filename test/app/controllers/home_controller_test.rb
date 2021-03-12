require './app/controllers/home_controller'

class HomeControllerTest < Test::Unit::TestCase
  def test_show
    controller = HomeController.new
    response = controller.show

    assert response[:status] == 200
    assert response[:body] == '<a href="/login">Login</a>'
    assert response[:headers]['Content-Type'] == 'text/html'
  end
end
