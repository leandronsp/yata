require './database/base_driver'

class FSDatabase < BaseDriver
  TABLES = {
    users: %w[id email password],
    tasks: %w[id name user_id]
  }.freeze

  def initialize(config)
    @dbpath = ".#{config[:dbname]}"
  end

  def createdb
    FileUtils.mkdir_p(@dbpath)
  end

  def dropdb
    TABLES.keys.each { |table_name| FileUtils.rm(filepath(table_name)) rescue nil }
  end

  def migratedb
    TABLES.keys.each { |table_name| FileUtils.touch(filepath(table_name)) }
  end

  def truncatedb
    dropdb
    createdb
    migratedb
  end

  def insert(table_name, *fields)
    new_id    = Time.now.to_i
    to_insert = [new_id, *fields]

    File.open(filepath(table_name), 'a') { |file| file.puts(to_insert.join(';')) }
    new_id
  end

  def delete(table_name, id)
    to_keep   = select_all(table_name).delete_if { |row| row['id'].to_s == id.to_s }
    new_state = to_keep.map { |row| row.to_a.transpose[1].join(";") }

    File.open(filepath(table_name), 'w') { |file| file.puts(new_state) }
  end

  def find(table_name, id)
    select_all(table_name).find { |row| row['id'].to_s == id.to_s }
  end

  def select_all(table_name)
    content = File.read(filepath(table_name))
    columns = TABLES[table_name.to_sym]

    content.split("\n").map do |row|
      values = row.split(';')
      columns.zip(values).to_h
    end
  end

  private

  def filepath(table_name)
    "#{@dbpath}/#{table_name}.txt"
  end
end
