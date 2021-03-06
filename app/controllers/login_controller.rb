require './app/controllers/base_controller'
require './app/frontend/components/login/view_model'
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

  def destroy
    render status: 301, 'Location' => "#{FULL_HOST}/",
                        'Set-Cookie' => "email=#{cookie[:email]}; path=/; HttpOnly; Expires=Thu, 01 Jan 1970 00:00:00 GMT"
  end
end
