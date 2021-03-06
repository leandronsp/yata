require 'test/unit'
require 'spy/integration'
require './database/db'
require 'byebug'

require './test/e2e/server_test_helper'

Dir[File.join(File.expand_path('..', __dir__), 'test', 'factories', '*.rb')].each { |f| require f }

load './config/environment.rb'

APP_ENV = 'test'

Test::Unit.at_start do
  DB.connection.createdb
end

Test::Unit.at_exit do
  DB.connection.dropdb
end
