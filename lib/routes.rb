require './lib/request'
require './lib/response'
require './app/errors/unauthorized_error'

Dir[File.join(File.expand_path('..', __dir__), 'app', 'controllers', '*_controller.rb')].each { |f| require f }

class Routes
  ROUTES_TABLE = {
    'GET /'             => :get_homepage_route,
    'GET /login'        => :get_login_route,
    'POST /login'       => :post_login_route,
    'GET /register'     => :get_register_route,
    'POST /register'    => :post_register_route,
    'POST /logout'      => :post_logout_route,
    'POST /tasks'       => :post_tasks_route,
    'DELETE /tasks/:id' => :delete_tasks_route
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

    route = first_lookup || second_lookup

    return not_found_route unless route

    begin
      send(route)
    rescue UnauthorizedError
      redirect_to_login
    end
  end

  private

  def first_lookup
    ROUTES_TABLE["#{@request.verb} #{@request.path}"]
  end

  def second_lookup
    constraint = @request.path.match(/^\/(tasks)\/([\w\d ]+)$/)
    return unless constraint

    resource_name, resource_id = constraint.values_at(1, 2)
    @request.add_param(:id, resource_id)
    ROUTES_TABLE["#{@request.verb} /#{resource_name}/:id"]
  end

  def redirect_to_login
    { status: 301, headers: { 'Location' => "#{FULL_HOST}/login" }}
  end

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

  def post_tasks_route
    controller = TasksController.new(params: @request.params,
                                     headers: @request.headers,
                                     cookie: @request.cookie)
    controller.create
  end

  def delete_tasks_route
    controller = TasksController.new(params: @request.params,
                                     headers: @request.headers,
                                     cookie: @request.cookie)
    controller.destroy
  end
end
