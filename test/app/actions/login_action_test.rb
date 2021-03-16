require 'bcrypt'
require './app/actions/login_action'

class LoginActionTest < Test::Unit::TestCase
  def test_login
    File.open('./db/users.txt', 'wb') do |file|
      file.write("test@acme.com;#{BCrypt::Password.create('pass123')}")
    end

    email = LoginAction.call('test@acme.com', 'pass123')
    assert_equal 'test@acme.com', email
  end
end
