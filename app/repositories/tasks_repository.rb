require './app/models/task'
require './app/models/user'
require './database/db'

class TasksRepository
  def initialize
    @database = DB.connection
  end

  def create_task(task)
    @database.insert('tasks', task.user.email, task.name)

    task
  end

  def delete_task(task)
    id = "#{task.user_email};#{task.name}"

    @database.delete('tasks', id)
  end

  def all_tasks_by_user(user)
    all.select { |model| model.user_email == user.email }
  end

  def all
    @database.select_all('tasks').map do |row|
      user = User.new(email: row[0])

      Task.new(user: user, name: row[1])
    end
  end
end
