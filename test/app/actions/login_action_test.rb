require './app/services/password_hashing'
require './app/actions/login_action'

class LoginActionTest < Test::Unit::TestCase
  def test_login
    File.open('./db/users.txt', 'wb') do |file|
      password_hash = PasswordHashing.generate_hash('pass123')
      file.write("test@acme.com;#{password_hash}")
    end

    email = LoginAction.call('test@acme.com', 'pass123')
    assert_equal 'test@acme.com', email
  end
end
