require 'test/unit'
require './app/repositories/emails_repository'
require './app/models/email'

class EmailsRepositoryTest < Test::Unit::TestCase
  def setup
    @model = Email.new(email: 'test@acme.com')
  end

  def test_save
    repository = EmailsRepository.new
    repository.save(@model)

    models = repository.all

    assert_equal 1, models.size
    assert_equal 'test@acme.com', models[0].email
  end

  def test_find_by_email
    repository = EmailsRepository.new
    repository.save(@model)

    model_found = repository.find_by_email('test@acme.com')

    assert_equal 'test@acme.com', model_found.email
  end
end
