require './app/controllers/base_controller'
require './app/actions/list_user_tasks_action'
require './app/frontend/components/home/view_model'

class HomeController < BaseController
  def show
    ensure_authentication!

    email = cookie[:email]
    tasks = ListUserTasksAction.call(email)
    body  = HomeViewModel.show(email, tasks)

    render status: 200, body: body, 'Content-Type' => 'text/html'
  end
end
