require 'socket'

server = TCPSocket.open('localhost', 4242)

server.puts 'Hello, server!'

server_response = server.gets
puts "Server response: #{server_response}"

server.close
