require './app/repositories/tasks_repository'

class TasksRepositoryTest < Test::Unit::TestCase
  def test_create_user
    repository = TasksRepository.new

    user = User.new(email: 'test@acme.com')
    task = Task.new(user: user, name: 'Task YAY!')

    task = repository.create_task(task)

    assert_equal 'test@acme.com', task.user_email
    assert_equal 'Task YAY!', task.name
  end
end
