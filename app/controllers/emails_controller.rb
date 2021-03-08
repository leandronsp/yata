require './app/actions/create_email_action'
require './app/actions/find_email_action'

class EmailsController
  def initialize(email)
    @email = email
  end

  def create
    CreateEmailAction.call(@email)
  end

  def show
    FindEmailAction.call(@email)
  end
end
