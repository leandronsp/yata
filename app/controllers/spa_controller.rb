require './app/controllers/base_controller'
require './app/views/spa/view_model'

class SpaController < BaseController
  def bootstrap
    body = SpaViewModel.show

    render status: 200, body: body, 'Content-Type' => 'text/html'
  end
end
