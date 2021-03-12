require './app/controllers/base_controller'
require './app/views/hello/view_model'

class HelloController < BaseController
  def show
    body = HelloViewModel.show

    render status: 200, body: body, 'Content-Type' => 'text/html'
  end
end
