require './database/pg_database'
require './database/fs_database'
require './database/pg_database'
require 'yaml'

class DB
  ADAPTERS = {
    postgres: PGDatabase,
    filesystem: FSDatabase
  }.freeze

  def self.connection
    @connection = new
  end

  def initialize
    yaml_data = YAML.load_file('./database/config.yml')
    dbconfig  = yaml_data[APP_ENV]
    db_klass  = ADAPTERS[dbconfig['adapter'].to_sym]

    @driver = db_klass.send(:driver, dbconfig)
  end

  def method_missing(m, *args, &block)
    @driver.send(m, *args, &block)
  end
end
