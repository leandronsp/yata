class RequestProcessor
  def self.process(request)
    lines = request.split("\n")

    first_line, second_line = lines.values_at(0, 1)

    puts first_line
    puts second_line

    if first_line == "GUARDAR email"
      email = second_line.chomp

      save_to_db(email)

      "CRIADO\nEmail <#{email}> guardado com sucesso"
    elsif first_line == "GET email"
      email = second_line.chomp

      exist_in_db?(email) ? "OK\n#{email}" : "NotFound"
    end
  end

  private

  def self.save_to_db(email)
    File.write('./db/emails.txt', email)
  end

  def self.exist_in_db?(email)
    content = File.read('./db/emails.txt')
    emails = content.split("\n")

    emails.include?(email)
  end
end
