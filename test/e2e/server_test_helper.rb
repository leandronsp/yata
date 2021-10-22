require 'socket'

module ServerTestHelper
  attr_reader :server

  def setup
    DB.connection.truncatedb rescue nil
    @server = TCPSocket.open('localhost', 3000)
  end

  def teardown
    @server.close
  end

  def refresh!
    @server.close
    @server = TCPSocket.open('localhost', 3000)
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
    str.gsub("\r\n", " ").gsub("\n", " ")
  end
end
