class EmailsController
  def initialize(email)
    @email = email
  end

  def create
    save_to_db
  end

  def show
    find_email
  end

  private

  def save_to_db
    File.write('./db/emails.txt', @email)
  end

  def find_email
    content = File.read('./db/emails.txt')
    emails = content.split("\n")

    return @email if emails.include?(@email)
    nil
  end
end
