require './app/models/task'
require './database/db'

module TaskFactory
  def create_task!(user:, name:)
    Task.new(user: user, name: name).tap do |task|
      DB.connection.insert('tasks', task.user_email, task.name)
    end
  end
end
