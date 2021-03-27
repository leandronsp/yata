require 'rack'
require './lib/routes'

class RackApp
  def call(env)
    request = Rack::Request.new(env)

    controller_response = Routes.route(*process_request(request))

    build_response(controller_response)
  end

  def process_request(request)
    verb = request.request_method
    path = request.path
    params = request.params.transform_keys(&:to_sym)
    headers = request.env
    cookies = request.cookies.transform_keys(&:to_sym)

    [verb, path, params, headers, cookies]
  end

  def build_response(attrs = {})
    status = attrs[:status]
    headers = attrs[:headers] || {}
    body = attrs[:body] || ''

    [status, headers, [body]]
  end
end
