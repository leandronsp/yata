require './app/actions/login_action'

class LoginActionTest < Test::Unit::TestCase
  def test_login
    repo_spy = Spy.on_instance_method(UsersRepository, :find_by_email_and_password)

    LoginAction.call('test@acme.com', 'pass123')

    assert repo_spy.has_been_called?
  end
end
