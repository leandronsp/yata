require './app/models/user'
require './app/actions/base_action'
require './app/repositories/users_repository'
require './app/repositories/tasks_repository'

class CreateTaskAction < BaseAction
  def initialize(email, task_name)
    user = UsersRepository.new.find_by_email(email)
    @task = Task.new(user: user, name: task_name)

    @tasks_repository = TasksRepository.new
  end

  def result
    @tasks_repository.create_task(@task)
  end
end
