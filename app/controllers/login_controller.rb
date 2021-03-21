require './app/controllers/base_controller'
require './app/views/login/view_model'
require './app/actions/login_action'

class LoginController < BaseController
  def show
    body = LoginViewModel.show

    render status: 200, body: body, 'Content-Type' => 'text/html'
  end

  def create
    email = LoginAction.call(params[:email], params[:password])

    if email
      render status: 301, 'Location' => "#{FULL_HOST}/",
                          'Set-Cookie' => "email=#{email}; path=/; HttpOnly"
    else
      render status: 401
    end
  end
end
