require './app/repositories/tasks_repository'

class TasksRepositoryTest < Test::Unit::TestCase
  def setup
    FileUtils.touch('./db/tasks.txt')
  end

  def test_create_user
    FileUtils.rm('./db/tasks.txt')

    repository = TasksRepository.new
    user = User.new(email: 'test@acme.com')
    task = Task.new(user: user, name: 'Task YAY!')

    repository.create_task(task)

    row = File.read('./db/tasks.txt').split("\n").first
    found_email, found_task = row.split(';')

    assert_equal found_email, task.user_email
    assert_equal found_task, task.name
  end
end
