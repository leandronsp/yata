require './test/e2e/server_test_helper'

class ServerTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_save_email
    server.puts "POST /emails HTTP/1.1\r\nContent-Length: 19\r\n\r\nemail=test@acme.com"

    assert_equal "HTTP/1.1 201\r\n\r\n\r\n", response

    content = File.read('./db/emails.txt')
    emails = content.split("\n")

    assert_equal 1, emails.size
    assert_equal 'test@acme.com', emails[0]
  end

  def test_get_email
    File.write('./db/emails.txt', 'test@acme.com')

    server.puts "GET /emails?email=test@acme.com HTTP/1.1\r\n\r\n\r\n"

    assert_equal "HTTP/1.1 200\r\nContent-Type: text/html\r\n\r\n<p>test@acme.com</p>\n", response
  end

  def test_get_email_not_found
    server.puts "GET /emails?email=notfound@acme.com HTTP/1.1\r\n\r\n\r\n"

    assert_equal "HTTP/1.1 404\r\n\r\n\r\n", response
  end

  def test_path_not_found
    server.puts "GET /seumadruga HTTP/1.1\r\n\r\n\r\n"

    assert_equal "HTTP/1.1 404\r\n\r\n\r\n", response
  end

  def test_get_hello
    server.puts "GET /hello HTTP/1.1\r\n\r\n"

    assert_equal "HTTP/1.1 200\r\nContent-Type: text/html\r\n\r\n<h1>Hello</h1>\n", response
  end
end
