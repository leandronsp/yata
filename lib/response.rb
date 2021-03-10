class Response
  attr_accessor :status, :body
  attr_reader :headers

  def initialize
    @status  = 418 # <----- Default: I'm a teapot!
    @body    = nil
    @headers = {}
  end

  def add_header(name, value)
    @headers[name] = value
  end
end
