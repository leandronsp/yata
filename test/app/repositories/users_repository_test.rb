require './app/repositories/users_repository'

class UsersRepositoryTest < Test::Unit::TestCase
  def setup
    FileUtils.touch('./db/users.txt')
  end

  def test_find_by_email_and_password
    File.open('./db/users.txt', 'wb') do |file|
      file.puts("test@acme.com;pass123")
    end

    repository = UsersRepository.new

    user = repository.find_by_email_and_password('test@acme.com', 'pass123')

    assert_equal 'test@acme.com', user.email
  end

  def test_create_user
    FileUtils.rm('./db/users.txt')

    repository = UsersRepository.new

    user = User.new(email: 'test@acme.com', password: 'pass123')
    email = repository.create_user(user)

    assert_equal 'test@acme.com', email

    content = File.read('./db/users.txt')
    assert_equal 1, content.split("\n").size
  end
end
