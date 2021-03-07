require './app/repositories/emails_repository'

class EmailsController
  def initialize(email)
    @email = email
    @emails_repository = EmailsRepository.new
  end

  def create
    @emails_repository.save(@email)
  end

  def show
    @emails_repository.find(@email)
  end
end
