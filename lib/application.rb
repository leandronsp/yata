require 'cgi'
require 'uri'
require 'socket'
require './lib/routes'

class Application
  def initialize(port)
    @socket = TCPServer.new(port)
  end

  def self.serve!(port)
    new(port).loop_forever!
  end

  def loop_forever!
    loop do
      # Waits for a new connection
      client = @socket.accept

      begin
        process!(client)
      rescue => error
        puts error
      end

      # Closes the client connection
      client.close
    end
  end

  private

  def process!(client)
    # Processes the request and routes to the application controllers
    controller_response = Routes.route(*parse_request(client))

    # Sends the response to the client
    response = build_response(controller_response)
    client.puts(response)
  end

  def parse_request(client)
    verb, path, uri_params = process_firstline(client)

    headers     = process_headers(client)
    body_params = process_body(client, headers['Content-Length'])
    params      = uri_params.merge(body_params)

    [verb, path, params, headers]
  end

  def process_body(client, content_length)
    return {} unless content_length
    raw_body = client.read(content_length.to_i)

    extract_params(CGI.unescape(raw_body))
  end

  def process_headers(client)
    headers = {}

    while line = client.gets
      break if line == "\r\n"

      header_name, header_value = line.split(": ")

      headers[header_name] = header_value
    end

    headers
  end

  def process_firstline(client)
    line = client.gets
    raise StandardError.new('Could not process the request') unless line

    verb, path, _ = line.split
    uri_path      = URI.parse(path)

    # [GET, /hello, {}]
    return [verb, uri_path.path, {}] unless uri_path.query

    uri_params = extract_params(uri_path.query)

    # [GET, /hello, { param_one: 1 }]
    [verb, uri_path.path, uri_params]
  end

  def extract_params(params_string)
    raw_params = params_string.split('&')

    raw_params.each_with_object({}) do |raw_param, acc|
      key, value      = raw_param.split('=')
      acc[key.to_sym] = value
    end
  end

  def build_response(status:, body: '', headers: [])
    status      = "HTTP/1.1 #{status}"
    headers_str = headers.join("\r\n")

    "#{status}\r\n#{headers_str}\r\n\r\n#{body}"
  end
end