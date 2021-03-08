require 'test/unit'
require 'spy/integration'

Test::Unit.at_start do
  FileUtils.touch('./db/emails.txt')
end

Test::Unit.at_exit do
  FileUtils.rm('./db/emails.txt') rescue nil
end
