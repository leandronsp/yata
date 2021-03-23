require 'test/unit'
require 'spy/integration'

require './test/e2e/server_test_helper'
require './test/factories/user'

load './config/environment.rb'

Test::Unit.at_start do
  FileUtils.touch('./db/users.txt')
end

Test::Unit.at_exit do
  FileUtils.rm('./db/users.txt') rescue nil
end
