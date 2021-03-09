require './app/actions/create_email_action'
require './app/actions/find_email_action'
require './app/views/emails_view_model'

class EmailsController
  def initialize(email)
    @email = email
  end

  def create
    CreateEmailAction.call(@email)

    EmailsViewModel.render_create(email: @email)
  end

  def show
    found = FindEmailAction.call(@email)

    EmailsViewModel.render_show(email: found)
  end
end
