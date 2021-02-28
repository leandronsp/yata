require 'socket'

server_connection = TCPSocket.open('localhost', 4242)

sleep 15

server_connection.close
