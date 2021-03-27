require './app/controllers/api'
require './app/controllers/base_controller'
require './app/actions/login_action'

module API
  class LoginController < BaseController
    def create
      email = LoginAction.call(params[:email], params[:password])

      if email
        render status: 200, body: json_response({ email: email }),
                            'Set-Cookie' => "email=#{email}; path=/; HttpOnly",
                            'Content-Type' => 'application/json'
      else
        render status: 401
      end
    end
  end
end
