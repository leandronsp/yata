require './app/actions/find_email_action'

class FindEmailActionTest < Test::Unit::TestCase
  def test_find_email
    model = Spy.mock(Email)
    Spy.on(model, :email).and_return('test@acme.com')

    Spy
      .on_instance_method(EmailsRepository, :find_by_email)
      .and_return(model)

    found = FindEmailAction.call('test@acme.com')

    assert_equal 'test@acme.com', found
  end
end
