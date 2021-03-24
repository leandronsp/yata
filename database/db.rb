require './database/fs_database'

class DB
  def self.connection
    @connection = new
  end

  def initialize
    @driver = FSDatabase.driver
  end

  def method_missing(m, *args, &block)
    @driver.send(m, *args, &block)
  end
end
