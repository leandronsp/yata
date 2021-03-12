require './lib/request'
require './lib/response'

Dir[File.join(File.expand_path('..', __dir__), 'app', 'controllers', '*_controller.rb')].each { |f| require f }

class Routes
  CONTROLLERS_ROUTER = {
    'GET /'        => :get_homepage_route,
    'GET /emails'  => :get_emails_route,
    'GET /hello'   => :get_hello_route,
    'POST /emails' => :post_emails_route
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
    return not_found_route unless route

    send(route)
  end

  private

  def not_found_route
    { status: 404, body: '<h1>Not Found</h1>', headers: { 'Content-Type' => 'text/html' }}
  end

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

  def get_homepage_route
    controller = HomeController.new(params: @request.params, headers: @request.headers)
    controller.show
  end
end
