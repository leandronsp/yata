require 'test/unit'
require 'socket'
require_relative '../test_helper'

class ServerTest < Test::Unit::TestCase
  include TestHelper

  def test_save_email
    server.puts "GUARDAR email\ntest@acme.com"

    assert_equal "CRIADO\nEmail <test@acme.com> guardado com sucesso\n", response
  end

  def test_get_email
    server.puts "GET email\ntest@acme.com"

    assert_equal "OK\ntest@acme.com\n", response
  end
end
