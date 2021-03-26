require './app/models/user'
require './app/actions/base_action'
require './app/repositories/tasks_repository'

class DeleteTaskAction < BaseAction
  def initialize(email, task_name)
    user = UsersRepository.new.find_by_email(email)
    @task = Task.new(user: user, name: task_name)

    @tasks_repository = TasksRepository.new
  end

  def result
    @tasks_repository.delete_task(@task)
  end
end
