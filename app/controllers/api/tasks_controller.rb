require './app/controllers/base_controller'
require './app/actions/list_user_tasks_action'

module API
  class TasksController < BaseController
    def index

      tasks = ListUserTasksAction.call(params[:email])

      render status: 200, body: json_response(tasks), 'Content-Type' => 'application/json'
    end
  end
end
