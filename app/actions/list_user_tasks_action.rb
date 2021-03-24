require './app/actions/base_action'
require './app/repositories/users_repository'
require './app/repositories/tasks_repository'

class ListUserTasksAction < BaseAction
  def initialize(email)
    @user = UsersRepository.new.find_by_email(email)

    @tasks_repository = TasksRepository.new
  end

  def result
    @tasks_repository.all_tasks_by_user(@user)
  end
end
