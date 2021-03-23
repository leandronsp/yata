require './app/controllers/base_controller'
require './app/actions/create_task_action'

class TasksController < BaseController
  def create
    task = CreateTaskAction.call(cookie[:email], params[:name])

    render status: 301, 'Location' => "#{FULL_HOST}/"
  end
end
