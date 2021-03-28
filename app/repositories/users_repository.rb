require './app/models/user'
require './database/db'

class UsersRepository
  def initialize
    @database = DB.connection
  end

  def create_user(user)
    @database.insert('users', user.email, user.password)

    user.email
  end

  def find_by_email(email)
    all.find { |model| model.email == email }
  end

  def all
    @database.select_all('users').map do |row|
      User.new(id: row['id'], email: row['email'], password: row['password'])
    end
  end
end
