require './app/actions/create_email_action'

class CreateEmailActionTest < Test::Unit::TestCase
  def test_create_email
    model = Spy.mock(Email)

    Spy.on(Email, :new).and_return(model)

    repo_spy = Spy.on_instance_method(EmailsRepository, :save)

    CreateEmailAction.call('test@acme.com')

    assert repo_spy.has_been_called_with?(model)
  end
end
