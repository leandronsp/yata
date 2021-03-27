require './app/controllers/base_controller'
require './app/frontend/components/register/view_model'
require './app/actions/register_action'
require './app/errors/password_not_match_error'
require './app/errors/email_already_taken_error'

class RegisterController < BaseController
  def show
    body = RegisterViewModel.show

    render status: 200, body: body, 'Content-Type' => 'text/html'
  end

  def create
    begin
      RegisterAction.call(params[:email],
                          params[:password],
                          params[:password_confirmation])

      render status: 301, 'Location' => "#{FULL_HOST}/login"
    rescue PasswordNotMatchError
      render status: 401, body: 'Password do not match'
    rescue EmailAlreadyTakenError
      render status: 401, body: 'Email already taken'
    end
  end
end
