require './app/controllers/emails_controller'

class EmailsControllerTest < Test::Unit::TestCase
  def test_create
    action_spy = Spy.on(CreateEmailAction, :call)

    controller = EmailsController.new(params: { email: 'test@acme.com' })
    response = controller.create

    assert action_spy.has_been_called?

    assert response[:status] == 201
  end

  def test_show
    action_spy = Spy.on(FindEmailAction, :call).and_return('test@acme.com')
    view_spy = Spy.on(EmailsViewModel, :show).and_call_through

    controller = EmailsController.new(params: { email: 'test@acme.com' })
    response = controller.show

    assert action_spy.has_been_called_with?('test@acme.com')
    assert view_spy.has_been_called?

    assert response[:status] = 200
    assert response[:body] = 'test@acme.com'
  end
end
