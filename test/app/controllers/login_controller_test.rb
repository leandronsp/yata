require './app/controllers/login_controller'

class LoginControllerTest < Test::Unit::TestCase
  def test_show
    controller = LoginController.new
    response = controller.show

    assert response[:status] == 200
    assert response[:headers]['Content-Type'] == 'text/html'
  end

  def test_create_success
    action_spy = Spy.on(LoginAction, :call).and_return('test@acme.com')

    controller = LoginController.new(params: { email: 'test@acme.com',
                                               password: 'pass123' })
    response = controller.create

    assert action_spy.has_been_called?

    assert response[:status] == 301
    assert response[:headers]['Location'] == 'http://localhost:3000/'
    assert response[:headers]['Set-Cookie'] == 'email=test@acme.com; path=/; HttpOnly'
  end

  def test_create_unauthorized
    action_spy = Spy.on(LoginAction, :call).and_return(nil)

    controller = LoginController.new(params: { email: 'test@acme.com',
                                               password: 'pass123' })
    response = controller.create

    assert action_spy.has_been_called?

    assert response[:status] == 401
  end

  def test_destroy_success
    controller = LoginController.new(cookie: { email: 'test@acme.com' })
    response = controller.destroy

    assert response[:status] == 301
    assert response[:headers]['Location'] == 'http://localhost:3000/'
    assert response[:headers]['Set-Cookie'] == 'email=test@acme.com; path=/; HttpOnly; Expires=Thu, 01 Jan 1970 00:00:00 GMT'
  end

end
