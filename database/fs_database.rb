class FSDatabase
  TABLES = %w[users tasks].freeze

  def self.driver
    @driver = new
  end

  def initialize
    @db_path = ".yata-db-#{APP_ENV}"
  end

  def createdb
    FileUtils.mkdir_p(@db_path)
  end

  def dropdb
    TABLES.each { |table_name| FileUtils.rm(filepath(table_name)) }
  end

  def migratedb
    TABLES.each { |table_name| FileUtils.touch(filepath(table_name)) }
  end

  def resetdb
    dropdb
    createdb
    migratedb
  end

  def insert(table_name, *fields)
    File.open(filepath(table_name), 'a') { |file| file.puts(fields.join(';')) }
  end

  def select_all(table_name)
    content = File.read(filepath(table_name))

    content.split("\n").map { |row| row.split(';') }
  end

  private

  def filepath(table_name)
    "#{@db_path}/#{table_name}.txt"
  end
end
