require './app/controllers/tasks_controller'
require './app/actions/create_task_action'
require './app/actions/list_user_tasks_action'

class TasksControllerTest < Test::Unit::TestCase
  include UserFactory
  include TaskFactory

  def test_create_success
    create_user!(email: 'test@acme.com')

    action_spy = Spy.on(CreateTaskAction, :call)
    action_spy = Spy.on(ListUserTasksAction, :call).and_return([])

    controller = TasksController.new(
      cookie: { email: 'test@acme.com' },
      params: { name: 'My first task!' }
    )

    response = controller.create

    assert action_spy.has_been_called?

    assert response[:status] == 200
  end

  def test_destroy_success
    user = create_user!(email: 'test@acme.com')
    create_task!(user: user, name: 'My first task!')

    action_spy = Spy.on(DeleteTaskAction, :call)

    controller = TasksController.new(
      cookie: { email: 'test@acme.com' },
      params: { id: 'My first task!' }
    )

    response = controller.destroy

    assert action_spy.has_been_called?

    assert response[:status] == 206
  end
end
