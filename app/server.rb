require 'socket'

socket = TCPServer.new(4242)

puts 'Listening to the port 4242'

# Uncomment the line below to see the server waiting 60 seconds before continue execution
# sleep 60

socket.close
