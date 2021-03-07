require 'test/unit'
require './app/repositories/emails_repository'

class EmailsRepositoryTest < Test::Unit::TestCase
  def test_save
    repository = EmailsRepository.new
    repository.save('test@acme.com')

    content = File.read('./db/emails.txt')
    emails = content.split("\n")

    assert_equal 1, emails.size
    assert_equal 'test@acme.com', emails[0]
  end

  def test_find
    File.write('./db/emails.txt', 'test@acme.com')

    repository = EmailsRepository.new
    found = repository.find('test@acme.com')

    assert_equal 'test@acme.com', found
  end
end
