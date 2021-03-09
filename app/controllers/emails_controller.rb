require './app/controllers/base_controller'
require './app/actions/create_email_action'
require './app/actions/find_email_action'
require './app/views/emails_view_model'

class EmailsController < BaseController
  def create
    CreateEmailAction.call(params[:email])

    render status: 201
  end

  def show
    found = FindEmailAction.call(params[:email])

    if found
      body = EmailsViewModel.show(email: found)
      render status: 200, body: body
    else
      render status: 404
    end
  end
end
