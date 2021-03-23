require './app/actions/login_action'

class LoginActionTest < Test::Unit::TestCase
  include UserFactory

  def test_login
    create_user!('test@acme.com')

    email = LoginAction.call('test@acme.com', 'pass123')

    assert_equal 'test@acme.com', email
  end
end
