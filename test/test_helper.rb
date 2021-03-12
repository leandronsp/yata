require 'test/unit'
require 'spy/integration'

Test::Unit.at_start do
  FileUtils.touch('./db/users.txt')
end

Test::Unit.at_exit do
  FileUtils.rm('./db/users.txt') rescue nil
end
