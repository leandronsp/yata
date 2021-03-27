require './app/frontend/view_model_base'

class LoginViewModel < ViewModelBase
  content './app/frontend/components/login/index.html'

  def show
    render
  end
end
