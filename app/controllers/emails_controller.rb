require './app/repositories/emails_repository'
require './app/models/email'

class EmailsController
  def initialize(email)
    @email_model = Email.new(email: email)
    @emails_repository = EmailsRepository.new
  end

  def create
    @emails_repository.save(@email_model)
  end

  def show
    model = @emails_repository.find_by_email(@email_model.email)
    model ? model.email : nil
  end
end
