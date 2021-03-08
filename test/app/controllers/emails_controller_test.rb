require './app/controllers/emails_controller'

class EmailsControllerTest < Test::Unit::TestCase
  def test_create
    action_spy = Spy.on(CreateEmailAction, :call)

    controller = EmailsController.new('test@acme.com')
    controller.create

    assert action_spy.has_been_called?
  end

  def test_show
    action_spy = Spy.on(FindEmailAction, :call)

    controller = EmailsController.new('test@acme.com')
    controller.show

    assert action_spy.has_been_called_with?('test@acme.com')
  end
end
