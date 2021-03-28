class User
  attr_accessor :id, :email, :password

  def initialize(attrs = {})
    @id = attrs[:id]
    @email = attrs[:email]
    @password = attrs[:password]
  end
end
