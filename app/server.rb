require 'socket'

socket = TCPServer.new(4242)

puts 'Listening to the port 4242'

loop do
  client = socket.accept

  client_request = client.gets
  puts "Client request: #{client_request}"

  response = 'Hey, client!'
  client.puts response

  client.close
end

socket.close
