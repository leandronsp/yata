require './lib/routes'
require './lib/api_routes'

class RouteProxy
  def self.proxy(*params)
    path = params[1]

    return APIRoutes.route(*params) if path.start_with?(/\/api/)

    Routes.route(*params)
  end
end
