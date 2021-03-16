require './app/models/user'
require './app/actions/base_action'
require './app/repositories/users_repository'
require './app/errors/password_not_match_error'
require './app/errors/email_already_taken_error'

class RegisterAction < BaseAction
  def initialize(email, password, password_confirmation)
    @user = User.new(email: email, password: password)
    @password_confirmation = password_confirmation

    @users_repository = UsersRepository.new
  end

  def result
    validate_password_match!
    validate_uniqueness_of_email!

    @users_repository.create_user(@user)
  end

  private

  def validate_password_match!
    return if @user.password == @password_confirmation

    raise PasswordNotMatchError
  end

  def validate_uniqueness_of_email!
    user = @users_repository.find_by_email(@user.email)
    return unless user

    raise EmailAlreadyTakenError
  end
end
