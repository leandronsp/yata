class BaseController
  attr_reader :params, :headers

  def initialize(params: {}, headers: [])
    @params = params
    @headers = headers
  end

  def render(status:, body: '', headers: [])
    { status: status, body: body, headers: headers }
  end
end
