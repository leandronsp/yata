require './app/models/user'
require './app/services/password_hashing'
require './database/db'

module UserFactory
  def create_user!(email:)
    User.new(email: email).tap do |user|
      password_hash = PasswordHashing.generate_hash('pass123')

      DB.connection.insert('users', user.email, password_hash)
    end
  end
end
