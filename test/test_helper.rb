require 'test/unit'
require 'spy/integration'

require './test/e2e/server_test_helper'

Dir[File.join(File.expand_path('..', __dir__), 'test', 'factories', '*.rb')].each { |f| require f }

load './config/environment.rb'

Test::Unit.at_start do
  FileUtils.touch('./db/users.txt')
  FileUtils.touch('./db/tasks.txt')
end

Test::Unit.at_exit do
  FileUtils.rm('./db/tasks.txt') rescue nil
  FileUtils.rm('./db/users.txt') rescue nil
end
