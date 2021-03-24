require './app/models/user'
require './app/services/password_hashing'

module UserFactory
  def create_user!(email:)
    User.new(email: email).tap do |user|
      File.open('./db/users.txt', 'wb') do |file|
        password_hash = PasswordHashing.generate_hash('pass123')
        file.puts("#{user.email};#{password_hash}")
      end
    end
  end
end
