require './app/services/password_hashing'

module UserFactory
  def create_user!(email)
    File.open('./db/users.txt', 'wb') do |file|
      password_hash = PasswordHashing.generate_hash('pass123')
      file.write("#{email};#{password_hash}")
    end
  end
end
