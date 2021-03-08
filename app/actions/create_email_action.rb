require './app/actions/base_action'
require './app/repositories/emails_repository'
require './app/models/email'

class CreateEmailAction < BaseAction
  def initialize(email)
    @model = Email.new(email: email)
    @emails_repository = EmailsRepository.new
  end

  def result
    @emails_repository.save(@model)
  end
end
