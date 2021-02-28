require 'socket'

server = TCPSocket.open('localhost', 4242)

request = "GUARDAR email\nleandro@acme.com"
server.puts request

loop do
  next_response_line = server.gets
  puts next_response_line

  break if next_response_line.nil?
end

server.close
