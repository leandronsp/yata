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
end
