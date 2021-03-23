require './app/actions/create_task_action'

class CreateTaskActionTest < Test::Unit::TestCase
  include UserFactory

  def setup
    FileUtils.rm('./db/users.txt')
    FileUtils.rm('./db/tasks.txt')
  end

  def test_create
    create_user!('test@acme.com')

    task = CreateTaskAction.call('test@acme.com', 'My first task!')

    assert_equal 'test@acme.com', task.user_email
    assert_equal 'My first task!', task.name

    row = File.read('./db/tasks.txt').split("\n").first
    found_email, found_task = row.split(';')

    assert_equal found_email, task.user_email
    assert_equal found_task, task.name
  end
end
