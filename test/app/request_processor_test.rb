require './app/request_processor'

class RequestProcessorTest < Test::Unit::TestCase
  def test_save_email
    controller_spy = Spy.on_instance_method(EmailsController, :create)

    request  = "GUARDAR email\ntest@acme.com"
    response = RequestProcessor.process(request)

    assert controller_spy.has_been_called?
    assert_equal "CRIADO\nEmail <test@acme.com> guardado com sucesso", response
  end

  def test_get_email
    Spy
      .on_instance_method(EmailsController, :show)
      .and_return('example@acme.com')

    request  = "GET email\nexample@acme.com"
    response = RequestProcessor.process(request)

    assert_equal "OK\nexample@acme.com", response
  end
end
