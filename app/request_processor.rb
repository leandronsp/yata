require './app/controllers/emails_controller'
require './app/controllers/hello_controller'

class RequestProcessor
  def self.process(request)
    lines = request.split("\n")

    first_line, second_line = lines.values_at(0, 1)

    if first_line == "GUARDAR email"
      email = second_line.chomp

      controller = EmailsController.new(email)
      controller.create
    elsif first_line == "GET email"
      email = second_line.chomp

      controller = EmailsController.new(email)
      controller.show
    elsif first_line.match(/.*?HTTP.*?/)
      ### HTTP ####
      verb, path, _, = first_line.split

      if verb == 'GET' && path == '/hello'
        controller = HelloController.new
        controller.show
      end
    end
  end
end
