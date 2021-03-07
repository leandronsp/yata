class EmailsRepository
  def initialize
    @emails_file = './db/emails.txt'
  end

  def save(email)
    File.write(@emails_file, email)
  end

  def find(email)
    all_emails.find { |record| record == email }
  end

  def all_emails
    content = File.read(@emails_file)
    content.split("\n")
  end
end
