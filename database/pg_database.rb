require './database/base_driver'
require 'pg'

class PGDatabase < BaseDriver
  def initialize(config)
    @connection = PG.connect(config.slice(:host, :port, :dbname,
                                          :user, :password))
  end

  def migratedb
    statements = [
      "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, \
                           email VARCHAR NOT NULL \,
                           password VARCHAR NOT NULL)",
      "CREATE TABLE IF NOT EXISTS tasks (id SERIAL PRIMARY KEY, \
                           name VARCHAR NOT NULL, \
                           user_id INT NOT NULL, \
                           CONSTRAINT fk_task_user FOREIGN KEY(user_id) REFERENCES users(id))"
    ]

    statements.each { |stmt| @connection.exec(stmt) }
  end

  def truncatedb
    statements = [
      "DROP TABLE tasks",
      "DROP TABLE users"
    ]

    statements.each { |stmt| @connection.exec(stmt) }

    migratedb
  end

  def insert(table_name, *fields)
    stmt = "INSERT INTO #{table_name} (#{columns_of(table_name)}) VALUES (#{prepare_fields(fields).join(', ')})"
    @connection.exec(stmt)
  end

  def delete(table_name, id)
    stmt = "DELETE FROM #{table_name} WHERE id = #{id}"
    @connection.exec(stmt)
  end

  def find(table_name, id)
    stmt = "SELECT * FROM #{table_name} WHERE id = #{id}"
    @connection.exec(stmt).entries.first
  end

  def select_all(table_name)
    stmt = "SELECT * FROM #{table_name}"
    @connection.exec(stmt).entries
  end

  private

  def columns_of(table_name)
    stmt = "SELECT column_name FROM information_schema.columns WHERE table_schema = 'public' \
            AND table_name = '#{table_name}' AND column_name != 'id'"

    @connection.exec(stmt).entries.map do |row|
      row['column_name']
    end.join(', ')
  end

  def prepare_fields(fields)
    fields.map do |field|
      "'#{field}'"
    end
  end
end
