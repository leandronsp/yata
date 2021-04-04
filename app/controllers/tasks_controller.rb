require './app/controllers/base_controller'
require './app/actions/create_task_action'
require './app/actions/delete_task_action'
require './app/actions/list_user_tasks_action'
require './app/frontend/components/home/view_model'

class TasksController < BaseController
  def create
    ensure_authentication!

    email = cookie[:email]

    CreateTaskAction.call(email, params[:name])

    tasks = ListUserTasksAction.call(email)
    body  = HomeViewModel.tasks_partial(tasks)

    render status: 200, body: body, 'Content-Type' => 'text/html'
  end

  def destroy
    ensure_authentication!

    DeleteTaskAction.call(params[:id])

    render status: 206
  end
end
