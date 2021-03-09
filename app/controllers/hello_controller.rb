require './app/views/hello_view_model'

class HelloController
  def show
    HelloViewModel.render_show
  end
end
