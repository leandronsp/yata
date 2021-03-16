require 'bcrypt'
require './app/actions/base_action'
require './app/repositories/users_repository'

class LoginAction < BaseAction
  def initialize(email, password)
    @email = email
    @password = password

    @users_repository = UsersRepository.new
  end

  def result
    user = @users_repository.find_by_email(@email)
    return unless user

    password_match?(user.password) ? user.email : nil
  end

  private

  def password_match?(password_hash)
    BCrypt::Password.new(password_hash) == @password
  end
end
