require './app/repositories/users_repository'

class UsersRepositoryTest < Test::Unit::TestCase
  def test_create_user
    repository = UsersRepository.new

    user = User.new(email: 'test@acme.com', password: 'pass123')
    email = repository.create_user(user)

    assert_equal 'test@acme.com', email
  end
end
