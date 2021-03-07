require 'test/unit'
require './app/controllers/emails_controller'

class EmailsControllerTest < Test::Unit::TestCase
  def test_create
    controller = EmailsController.new('test@acme.com')
    controller.create

    content = File.read('./db/emails.txt')
    emails = content.split("\n")

    assert_equal 1, emails.size
    assert_equal 'test@acme.com', emails[0]
  end

  def test_show
    File.write('./db/emails.txt', 'test@acme.com')

    controller = EmailsController.new('test@acme.com')
    found = controller.show

    assert_equal 'test@acme.com', found
  end
end
