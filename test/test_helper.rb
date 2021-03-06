require 'socket'

module TestHelper
  attr_reader :server

  def setup
    @server = TCPSocket.open('localhost', 4242)
  end

  def teardown
    @server.close
  end

  def response
    acc = ''

    while line = @server.gets
      acc += line
    end

    acc
  end
end
