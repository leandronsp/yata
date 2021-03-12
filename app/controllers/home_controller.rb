require './app/controllers/base_controller'
require './app/views/home/view_model'

class HomeController < BaseController
  def show
    body = HomeViewModel.show

    render status: 200, body: body, 'Content-Type' => 'text/html'
  end
end
