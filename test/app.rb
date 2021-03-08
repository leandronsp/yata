require './test/test_helper'

PROJECT_ROOT = File.expand_path('..', __dir__)

Dir[File.join(PROJECT_ROOT, 'test', 'app', '**', '*_test.rb')].each { |f| require f }
