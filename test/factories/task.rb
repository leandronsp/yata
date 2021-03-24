require './app/models/task'

module TaskFactory
  def create_task!(user:, name:)
    Task.new(user: user, name: name).tap do |task|
      File.open('./db/tasks.txt', 'wb') do |file|
        file.puts("#{task.user_email};#{task.name}")
      end
    end
  end
end
