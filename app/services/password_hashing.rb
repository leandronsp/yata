require 'bcrypt'

class PasswordHashing
  def self.generate_hash(password)
    BCrypt::Password.create(password)
  end

  def self.match?(password_hash, raw_password)
    BCrypt::Password.new(password_hash) == raw_password
  end
end
