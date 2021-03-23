require './app/controllers/base_controller'
require './app/actions/list_user_tasks_action'
require './app/views/home/view_model'

class HomeController < BaseController
  def show
    if email = cookie[:email]
      tasks = ListUserTasksAction.call(email)
      body = HomeViewModel.show(email, tasks)
    else
      body = HomeViewModel.show
    end

    render status: 200, body: body, 'Content-Type' => 'text/html'
  end
end
