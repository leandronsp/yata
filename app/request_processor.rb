require './app/controllers/emails_controller'

class RequestProcessor
  def self.process(request)
    lines = request.split("\n")

    first_line, second_line = lines.values_at(0, 1)

    if first_line == "GUARDAR email"
      email = second_line.chomp

      controller = EmailsController.new(email)
      controller.create

      "CRIADO\nEmail <#{email}> guardado com sucesso"
    elsif first_line == "GET email"
      email = second_line.chomp

      controller = EmailsController.new(email)
      found = controller.show

      found ? "OK\n#{found}" : "NotFound"
    end
  end
end
