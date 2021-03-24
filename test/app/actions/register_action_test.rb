require './app/actions/register_action'
require './app/errors/password_not_match_error'
require './app/errors/email_already_taken_error'
require './database/db'

class RegisterActionTest < Test::Unit::TestCase
  include UserFactory

  def setup
    DB.connection.resetdb
  end

  def test_register
    email = RegisterAction.call('test@acme.com', 'pass123', 'pass123')
    assert_equal 'test@acme.com', email
  end

  def test_register_password_not_match
    assert_raise PasswordNotMatchError do
      RegisterAction.call('test@acme.com', 'pass123', 'notmatch')
    end
  end

  def test_register_existing_email
    create_user!(email: 'test@acme.com')

    assert_raise EmailAlreadyTakenError do
      RegisterAction.call('test@acme.com', 'pass123', 'pass123')
    end
  end
end
