class LoginViewModel
  def self.show
    File.read('./app/views/login/form.html')
  end
end
