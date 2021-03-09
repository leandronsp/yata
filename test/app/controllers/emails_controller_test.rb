require './app/controllers/emails_controller'

class EmailsControllerTest < Test::Unit::TestCase
  def test_create
    action_spy = Spy.on(CreateEmailAction, :call)
    view_spy = Spy.on(EmailsViewModel, :render_create).and_call_through

    controller = EmailsController.new('test@acme.com')
    view_content = controller.create

    assert action_spy.has_been_called?
    assert view_spy.has_been_called?
    assert_equal "CRIADO\nEmail <test@acme.com> guardado com sucesso", view_content
  end

  def test_show
    action_spy = Spy.on(FindEmailAction, :call).and_return('test@acme.com')
    view_spy = Spy.on(EmailsViewModel, :render_show).and_call_through

    controller = EmailsController.new('test@acme.com')
    view_content = controller.show

    assert action_spy.has_been_called_with?('test@acme.com')
    assert view_spy.has_been_called?
    assert_equal "OK\ntest@acme.com", view_content
  end
end
