require './app/controllers/base_controller'
require './app/views/home_guest/view_model'

class HomeGuestController < BaseController
  def show
    body = HomeGuestViewModel.show
    render status: 200, body: body, 'Content-Type' => 'text/html'
  end
end
