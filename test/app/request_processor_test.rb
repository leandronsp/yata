require './app/request_processor'

class RequestProcessorTest < Test::Unit::TestCase
  def test_save_email
    controller_spy = Spy.on_instance_method(EmailsController, :create)

    request  = "GUARDAR email\ntest@acme.com"
    response = RequestProcessor.process(request)

    assert controller_spy.has_been_called?
  end

  def test_get_email
    controller_spy = Spy.on_instance_method(EmailsController, :show)

    request  = "GET email\nexample@acme.com"
    response = RequestProcessor.process(request)

    assert controller_spy.has_been_called?
  end

  def test_get_hello
    controller_spy = Spy.on_instance_method(HelloController, :show)

    request  = "GET /hello HTTP/1.1"
    response = RequestProcessor.process(request)

    assert controller_spy.has_been_called?
  end
end
