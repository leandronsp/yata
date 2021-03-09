require './app/controllers/emails_controller'
require './app/controllers/hello_controller'

class Routes
  CONTROLLERS_ROUTER = {
    'GET /emails'  => :get_emails_route,
    'GET /hello'   => :get_hello_route,
    'POST /emails' => :post_emails_route,
  }.freeze

  def self.route(verb, path, params, headers)
    new(verb, path, params, headers).process
  end

  def initialize(verb, path, params, headers)
    @verb, @path, @params, @headers = verb, path, params, headers
  end

  def process
    route = CONTROLLERS_ROUTER["#{@verb} #{@path}"]
    return { status: 404 } unless route

    send(route)
  end

  private

  def get_emails_route
    controller = EmailsController.new(params: @params, headers: @headers)
    controller.show
  end

  def get_hello_route
    controller = HelloController.new(params: @params, headers: @headers)
    controller.show
  end

  def post_emails_route
    controller = EmailsController.new(params: @params, headers: @headers)
    controller.create
  end
end
