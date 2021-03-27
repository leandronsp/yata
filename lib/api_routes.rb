require './lib/request'
require './lib/response'
require './lib/routes'

Dir[File.join(File.expand_path('..', __dir__), 'app', 'controllers', 'api', '*_controller.rb')].each { |f| require f }

class APIRoutes < Routes
  API_ROUTES_TABLE = {
    'POST /api/login' => :post_login_route,
    'GET /api/users/:id/tasks' => :get_user_tasks_route
  }.freeze

  def process
    route = first_lookup || second_lookup

    return not_found_route unless route

    begin
      send(route)
    rescue UnauthorizedError
      respond_unauthorized
    end
  end

  private

  def first_lookup
    API_ROUTES_TABLE["#{@request.verb} #{@request.path}"]
  end

  def second_lookup
    constraint = @request.path.match(/^\/api\/(users)\/(.*?)\/(tasks)$/)
    return unless constraint

    resource_name, resource_id, resource_collection = constraint.values_at(1, 2, 3)
    @request.add_param(:id, resource_id)
    puts "/api/#{resource_name}/:id/#{resource_collection}"
    API_ROUTES_TABLE["#{@request.verb} /api/#{resource_name}/:id/#{resource_collection}"]
  end

  def respond_unauthorized
    { status: 401 }
  end

  def not_found_route
    { status: 404, headers: { 'Content-Type' => 'application/json' }}
  end

  def post_login_route
    controller = API::LoginController.new(params: @request.params,
                                          headers: @request.headers,
                                          cookie: @request.cookie)
    controller.create
  end

  def get_user_tasks_route
    controller = API::TasksController.new(params: @request.params,
                                     headers: @request.headers,
                                     cookie: @request.cookie)
    controller.index
  end
end
