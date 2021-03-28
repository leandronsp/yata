require './app/models/task'
require './database/db'

module TaskFactory
  def create_task!(user:, name:)
    Task.new(user: user, name: name).tap do |task|
      task_id = DB.connection.insert('tasks', task.name, task.user_id)
      task.id = task_id
    end
  end
end
