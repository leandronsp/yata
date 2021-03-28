require './app/models/task'
require './app/models/user'
require './database/db'

class TasksRepository
  def initialize
    @database = DB.connection
  end

  def create_task(task)
    @database.insert('tasks', task.name, task.user_id)

    task
  end

  def delete_task(task)
    @database.delete('tasks', task.id)
  end

  def all_tasks_by_user(user)
    all.select { |model| model.user_email == user.email }
  end

  def all
    @database.select_all('tasks').map do |row|
      user_row = @database.find('users', row['user_id'])
      user = User.new(id: user_row['id'], email: user_row['email'], password: user_row['password'])

      Task.new(user: user, id: row['id'], name: row['name'])
    end
  end
end
