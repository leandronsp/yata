class User
  attr_reader :email, :password

  def initialize(attrs = {})
    @email = attrs[:email]
    @password = attrs[:password]
  end
end
