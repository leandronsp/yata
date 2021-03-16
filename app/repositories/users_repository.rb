require 'bcrypt'
require './app/models/user'

class UsersRepository
  def initialize
    @users_db = './db/users.txt'
    FileUtils.touch(@users_db)
  end

  def create_user(user)
    File.open(@users_db, 'a') do |file|
      file.puts("#{user.email};#{BCrypt::Password.create(user.password)}")
    end

    user.email
  end

  def find_by_email(email)
    all.find { |model| model.email == email }
  end

  def find_by_email_and_password(email, password)
    all.find do |model|
      model.email == email &&
        BCrypt::Password.new(model.password) == password
    end
  end

  def all
    content = File.read(@users_db)

    content.split("\n").map do |row|
      email, password = row.split(';')
      User.new(email: email, password: password)
    end
  end
end
