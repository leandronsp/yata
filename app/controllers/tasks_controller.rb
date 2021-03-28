require './app/controllers/base_controller'
require './app/actions/create_task_action'
require './app/actions/delete_task_action'

class TasksController < BaseController
  def create
    ensure_authentication!

    task = CreateTaskAction.call(cookie[:email], params[:name])

    render status: 301, 'Location' => "#{FULL_HOST}/"
  end

  def destroy
    ensure_authentication!

    DeleteTaskAction.call(params[:id])

    render status: 206
  end
end
