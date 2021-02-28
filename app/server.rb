require 'socket'

socket = TCPServer.new(4242)

puts 'Listening to the port 4242'

loop do
  client = socket.accept

  first_line = client.gets
  puts first_line

  second_line = client.gets
  puts second_line

  if first_line == "GUARDAR email\n"
    email = second_line.chomp
    response = "CRIADO\nEmail <#{email}> guardado com sucesso"
    client.puts response
  end

  client.close
end

socket.close
