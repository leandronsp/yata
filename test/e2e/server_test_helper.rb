require 'socket'

module ServerTestHelper
  attr_reader :server

  def setup
    @server = TCPSocket.open('localhost', 4242)
  end

  def teardown
    @server.close
  end

  def refresh!
    @server.close
    @server = TCPSocket.open('localhost', 4242)
  end

  def prepare_request(action, headers = '', body = '')
    "#{action} HTTP/1.1\r\n#{headers}\r\n\r\n#{body}"
  end

  def response
    acc = ''

    while line = @server.gets
      acc += line
    end

    acc
  end

  def remove_cr(str)
    str.gsub("\r\n", " ")
  end
end
