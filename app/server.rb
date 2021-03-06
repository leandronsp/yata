require 'socket'

socket = TCPServer.new(4242)

puts 'Listening to the port 4242'

def save_to_db(email)
  File.write('./db/emails.txt', email)
end

def exist_in_db?(email)
  content = File.read('./db/emails.txt')
  emails = content.split("\n")

  emails.include?(email)
end

loop do
  client = socket.accept

  first_line = client.gets
  puts first_line

  second_line = client.gets
  puts second_line

  if first_line == "GUARDAR email\n"
    email = second_line.chomp

    save_to_db(email)

    response = "CRIADO\nEmail <#{email}> guardado com sucesso"
    client.puts response
  elsif first_line == "GET email\n"
    email = second_line.chomp

    if exist_in_db?(email)
      response = "OK\n#{email}"
    else
      response = "NotFound\n"
    end

    client.puts response
  end

  client.close
end

socket.close
