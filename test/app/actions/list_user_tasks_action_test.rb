require './app/actions/list_user_tasks_action'

class ListUserTasksActionTest < Test::Unit::TestCase
  include UserFactory
  include TaskFactory

  def test_create
    user = create_user!(email: 'test@acme.com')
    task = create_task!(user: user, name: 'My first task')

    tasks = ListUserTasksAction.call('test@acme.com')

    assert_equal 1, tasks.size
    assert_equal 'My first task', tasks.first.name
    assert_equal 'test@acme.com', tasks.first.user_email
  end
end
