class Request
  attr_reader :verb, :path, :params, :headers

  def initialize(verb, path, params, headers)
    @verb, @path, @params, @headers = verb, path, params, headers
  end
end
