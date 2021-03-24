require './app/actions/base_action'
require './app/repositories/users_repository'

class FindUserAction < BaseAction
  def initialize(email)
    @email = email

    @users_repository = UsersRepository.new
  end

  def result
    @users_repository.find_by_email(@email)
  end
end
