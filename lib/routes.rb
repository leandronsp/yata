require './app/controllers/emails_controller'
require './app/controllers/hello_controller'
require './lib/request'
require './lib/response'

class Routes
  CONTROLLERS_ROUTER = {
    'GET /emails'  => :get_emails_route,
    'GET /hello'   => :get_hello_route,
    'POST /emails' => :post_emails_route,
  }.freeze

  def self.route(verb, path, params, headers)
    request = Request.new(verb, path, params, headers)
    response = Response.new

    new(request, response).process
  end

  def initialize(request, response)
    @request = request
    @response = response
  end

  def process
    route = CONTROLLERS_ROUTER["#{@request.verb} #{@request.path}"]
    return { status: 404 } unless route

    send(route)
  end

  private

  def get_emails_route
    controller = EmailsController.new(params: @request.params, headers: @request.headers)
    controller.show
  end

  def get_hello_route
    controller = HelloController.new(params: @request.params, headers: @request.headers)
    controller.show
  end

  def post_emails_route
    controller = EmailsController.new(params: @request.params, headers: @request.headers)
    controller.create
  end
end
