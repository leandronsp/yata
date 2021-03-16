class RegisterViewModel
  def self.show
    File.read('./app/views/register/form.html')
  end
end
