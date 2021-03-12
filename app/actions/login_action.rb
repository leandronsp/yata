require './app/actions/base_action'
require './app/repositories/users_repository'

class LoginAction < BaseAction
  def initialize(email, password)
    @email = email
    @password = password

    @users_repository = UsersRepository.new
  end

  def result
    user = @users_repository.find_by_email_and_password(@email, @password)

    user ? user.email : nil
  end
end
