require 'rack'
require 'json'
require './lib/routes'
require 'byebug'

class RackApp
  def call(env)
    request = Rack::Request.new(env)

    controller_response = Routes.route(*process_request(request))

    build_response(controller_response)
  end

  def process_request(request)
    verb    = request.request_method
    path    = request.path
    params  = process_params(request)
    headers = request.env
    cookies = request.cookies.transform_keys(&:to_sym)

    [verb, path, params, headers, cookies]
  end

  def process_params(request)
    request_params = request.params
    body_params    = request.post? ? (JSON.parse(request.body.read) rescue {}) : {}

    request_params.merge(body_params).transform_keys(&:to_sym)
  end

  def build_response(attrs = {})
    status = attrs[:status]
    headers = attrs[:headers] || {}
    body = attrs[:body] || ''

    [status, headers, [body]]
  end
end
