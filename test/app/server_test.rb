require 'test/unit'
require 'socket'
require './test/server_test_helper'

class ServerTest < Test::Unit::TestCase
  include ServerTestHelper

  def test_save_email
    server.puts "GUARDAR email\ntest@acme.com\n\n"

    assert_equal "CRIADO\nEmail <test@acme.com> guardado com sucesso\n", response

    content = File.read('./db/emails.txt')
    emails = content.split("\n")

    assert_equal 1, emails.size
    assert_equal 'test@acme.com', emails[0]
  end

  def test_get_email
    server.puts "GET email\ntest@acme.com\n\n"

    assert_equal "OK\ntest@acme.com\n", response
  end

  def test_get_email_not_found
    server.puts "GET email\nnotfound@acme.com\n\n"

    assert_equal "NotFound\n", response
  end
end
