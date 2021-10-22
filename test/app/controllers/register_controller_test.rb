require './app/controllers/register_controller'
require './app/actions/register_action'

class RegisterControllerTest < Test::Unit::TestCase
  def test_show
    controller = RegisterController.new
    response = controller.show

    assert response[:status] == 200
    assert response[:headers]['Content-Type'] == 'text/html'
  end

  def test_create_success
    action_spy = Spy.on(RegisterAction, :call)

    controller = RegisterController.new(params: {
      email: 'test@acme.com',
      password: 'pass123',
      password_confirmation: 'pass123'
    })

    response = controller.create

    assert action_spy.has_been_called?

    assert response[:status] == 301
    assert response[:headers]['Location'] == 'http://localhost:3000/login'
  end
end
