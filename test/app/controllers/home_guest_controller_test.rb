require './app/controllers/home_guest_controller'

class HomeGuestControllerTest < Test::Unit::TestCase
  def test_show
    controller = HomeGuestController.new
    response = controller.show

    assert response[:status] == 200
    assert response[:headers]['Content-Type'] == 'text/html'
  end
end
