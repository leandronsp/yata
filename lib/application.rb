load './lib/app.ru'
require 'rack/handler/puma'

class Application
  def self.serve!(port)
    if ENV['SERVER_NAME'] == 'thin'
      handler = Rack::Handler::Thin
    else
      handler = Rack::Handler::Puma
    end

    handler.run RackApp.new, Port: port
  end
end
