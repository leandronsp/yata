require './app/controllers/base_controller'
require './app/views/login/view_model'

class LoginController < BaseController
  def show
    body = LoginViewModel.show

    render status: 200, body: body, 'Content-Type' => 'text/html'
  end
end
