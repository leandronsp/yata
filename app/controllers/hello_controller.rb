require './app/controllers/base_controller'
require './app/views/hello_view_model'

class HelloController < BaseController
  def show
    body = HelloViewModel.show

    render status: 200, body: body
  end
end
