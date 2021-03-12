class Request
  attr_reader :verb, :path, :params, :headers, :cookie

  def initialize(verb, path, params, headers, cookie)
    @verb, @path, @params, @headers, @cookie = verb, path, params, headers, cookie
  end
end
