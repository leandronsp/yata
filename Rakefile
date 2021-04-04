require './database/db'
load './config/environment.rb'

task :createdb do
  DB.connection.createdb
end

task :migratedb do
  DB.connection.migratedb
end

task :test do
  ruby "test/app.rb"
end

task :server do
  ruby "./lib/run-server"
end

task :e2e do
  sh "./test/run-e2e"
end
