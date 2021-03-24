require './app/actions/create_task_action'

class CreateTaskActionTest < Test::Unit::TestCase
  include UserFactory

  def test_create
    create_user!(email: 'test@acme.com')

    task = CreateTaskAction.call('test@acme.com', 'My first task!')

    assert_equal 'test@acme.com', task.user_email
    assert_equal 'My first task!', task.name
  end
end
