require 'test/unit'
require './app/request_processor'

class RequestProcessorTest < Test::Unit::TestCase
  def test_process_request
    request  = "GUARDAR email\ntest@acme.com"
    response = RequestProcessor.process(request)

    assert_equal "CRIADO\nEmail <test@acme.com> guardado com sucesso", response
  end
end
