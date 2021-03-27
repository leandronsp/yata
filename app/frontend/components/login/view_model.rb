class LoginViewModel
  def self.show
    File.read('./app/frontend/components/login/index.html')
  end
end
