class BaseController
  attr_reader :params, :headers, :cookie

  def initialize(params: {}, headers: {}, cookie: {})
    @params = params
    @headers = headers
    @cookie = cookie
  end

  def render(response_params = {})
    status = response_params[:status]
    body   = response_params[:body] || ''

    response_headers = response_params.reject { |k, v| %i[status body].include?(k) }

    { status: status, body: body, headers: response_headers }
  end
end
