require './app/frontend/view_model_base'

class RegisterViewModel < ViewModelBase
  content './app/frontend/components/register/index.html'

  def show
    render
  end
end
