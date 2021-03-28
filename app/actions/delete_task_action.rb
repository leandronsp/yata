require './app/models/user'
require './app/actions/base_action'
require './app/repositories/tasks_repository'

class DeleteTaskAction < BaseAction
  def initialize(task_id)
    @task = Task.new(id: task_id)

    @tasks_repository = TasksRepository.new
  end

  def result
    @tasks_repository.delete_task(@task)
  end
end
