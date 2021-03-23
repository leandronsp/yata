require './lib/request'
require './lib/response'

Dir[File.join(File.expand_path('..', __dir__), 'app', 'controllers', '*_controller.rb')].each { |f| require f }

class Routes
  CONTROLLERS_ROUTER = {
    'GET /'          => :get_homepage_route,
    'GET /login'     => :get_login_route,
    'POST /login'    => :post_login_route,
    'GET /register'  => :get_register_route,
    'POST /register' => :post_register_route,
    'POST /logout'   => :post_logout_route
  }.freeze

  def self.route(verb, path, params, headers, cookie)
    request = Request.new(verb, path, params, headers, cookie)
    response = Response.new

    new(request, response).process
  end

  def initialize(request, response)
    @request = request
    @response = response
  end

  def process
    return static_asset_route if @request.static_asset?

    route = CONTROLLERS_ROUTER["#{@request.verb} #{@request.path}"]
    return not_found_route unless route

    send(route)
  end

  private

  def static_asset_route
    return not_found_route unless File.exists?(@request.static_asset_path)

    body = File.read(@request.static_asset_path)

    { status: 200, body: body }
  end

  def not_found_route
    { status: 404, body: '<h1>Not Found</h1>', headers: { 'Content-Type' => 'text/html' }}
  end

  def get_homepage_route
    controller = HomeController.new(params: @request.params,
                                      headers: @request.headers,
                                      cookie: @request.cookie)
    controller.show
  end

  def get_login_route
    controller = LoginController.new(params: @request.params,
                                      headers: @request.headers,
                                      cookie: @request.cookie)
    controller.show
  end

  def post_login_route
    controller = LoginController.new(params: @request.params,
                                      headers: @request.headers,
                                      cookie: @request.cookie)
    controller.create
  end

  def post_logout_route
    controller = LoginController.new(params: @request.params,
                                     headers: @request.headers,
                                     cookie: @request.cookie)
    controller.destroy
  end

  def get_register_route
    controller = RegisterController.new(params: @request.params,
                                     headers: @request.headers,
                                     cookie: @request.cookie)
    controller.show
  end

  def post_register_route
    controller = RegisterController.new(params: @request.params,
                                     headers: @request.headers,
                                     cookie: @request.cookie)
    controller.create
  end
end
