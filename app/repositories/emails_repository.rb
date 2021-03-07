class EmailsRepository
  def initialize
    @emails_file = './db/emails.txt'
  end

  def save(model)
    File.write(@emails_file, model.email)
  end

  def find_by_email(email)
    all.find { |model| model.email == email }
  end

  def all
    content = File.read(@emails_file)
    content.split("\n").map { |email| Email.new(email: email) }
  end
end
