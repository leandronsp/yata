require './app/actions/delete_task_action'
require './app/repositories/tasks_repository'

class DeleteTaskActionTest < Test::Unit::TestCase
  include UserFactory
  include TaskFactory

  def setup
    DB.connection.resetdb
  end

  def test_create
    user = create_user!(email: 'test@acme.com')
    create_task!(user: user, name: 'My first task!')

    DeleteTaskAction.call('test@acme.com', 'My first task!')

    user_tasks = TasksRepository.new.all_tasks_by_user(user)
    assert_equal 0, user_tasks.size
  end
end
