require './app/models/task'
require './app/models/user'

class TasksRepository
  def initialize
    @tasks_db = './db/tasks.txt'
    FileUtils.touch(@tasks_db)
  end

  def create_task(task)
    File.open(@tasks_db, 'a') do |file|
      file.puts("#{task.user_email};#{task.name}")
    end

    task
  end

  def all_tasks_by_user(user)
    all.select { |model| model.user_email == user.email }
  end

  def all
    content = File.read(@tasks_db)

    content.split("\n").map do |row|
      user_email, task_name = row.split(';')

      user = User.new(email: user_email)
      Task.new(user: user, name: task_name)
    end
  end
end
