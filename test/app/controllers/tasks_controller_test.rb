require './app/controllers/tasks_controller'
require './app/actions/create_task_action'

class TasksControllerTest < Test::Unit::TestCase
  include UserFactory

  def test_create_success
    create_user!(email: 'test@acme.com')

    action_spy = Spy.on(CreateTaskAction, :call)

    controller = TasksController.new(
      cookie: { email: 'test@acme.com' },
      params: { name: 'My first task!' }
    )

    response = controller.create

    assert action_spy.has_been_called?

    assert response[:status] == 301
    assert response[:headers]['Location'] == 'http://localhost:4242/'
  end
end
