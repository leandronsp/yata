require './app/services/password_hashing'
require './app/actions/register_action'
require './app/errors/password_not_match_error'
require './app/errors/email_already_taken_error'

class RegisterActionTest < Test::Unit::TestCase
  include UserFactory

  def setup
    FileUtils.rm('./db/users.txt')
  end

  def test_register
    email = RegisterAction.call('test@acme.com', 'pass123', 'pass123')
    assert_equal 'test@acme.com', email

    row = File.read('./db/users.txt').split("\n").first
    found_email, password_hash = row.split(';')

    assert_equal found_email, email
    assert PasswordHashing.match?(password_hash, 'pass123')
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
