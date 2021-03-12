require './app/models/user'

class UsersRepository
  def initialize
    @users_db = './db/users.txt'
  end

  def find_by_email_and_password(email, password)
    all.find do |model|
      model.email == email && model.password == password
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
