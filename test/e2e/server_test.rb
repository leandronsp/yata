require './test/e2e/server_test_helper'

class ServerTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_save_email
    server.puts "GUARDAR email\ntest@acme.com\n\r\n"

    assert_equal "CRIADO\nEmail <test@acme.com> guardado com sucesso\n", response

    content = File.read('./db/emails.txt')
    emails = content.split("\n")

    assert_equal 1, emails.size
    assert_equal 'test@acme.com', emails[0]
  end

  def test_get_email
    File.write('./db/emails.txt', 'test@acme.com')

    server.puts "GET email\ntest@acme.com\n\r\n"

    assert_equal "OK\ntest@acme.com\n", response
  end

  def test_get_email_not_found
    server.puts "GET email\nnotfound@acme.com\n\r\n"

    assert_equal "NotFound\n", response
  end

  def test_get_hello_http
    server.puts "GET /hello HTTP/1.1\r\n\r\n"

    assert_equal "HTTP/1.1 200\r\n\r\nHello\n", response
  end
end
