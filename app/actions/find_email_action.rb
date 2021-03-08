require './app/actions/base_action'
require './app/repositories/emails_repository'
require './app/models/email'

class FindEmailAction < BaseAction
  def initialize(email)
    @model = Email.new(email: email)
    @emails_repository = EmailsRepository.new
  end

  def result
    found = @emails_repository.find_by_email(@model.email)
    found ? found.email : nil
  end
end
