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
  ruby "./bin/server"
end

task :e2e do
  sh "./bin/test-e2e"
end

task :createpg, [:sudoer] do |t, args|
  app_env = ENV['APP_ENV'] || 'development'

  container = "yata_#{app_env}"
  dbname    = "yata_#{app_env}"
  username  = "yata"
  password  = "yata"

  root_command = args[:sudoer] ? "sudo docker" : "docker"

  command = %{
    #{root_command} run \
      --name #{container} \
      -e POSTGRES_USER=#{username} \
      -e POSTGRES_PASSWORD=#{password} \
      -e POSTGRES_DB=#{dbname} \
      -e PGDATA=/var/lib/postgresql/data/pgdata  \
      -v $HOME/.#{dbname}/data:/var/lib/postgresql/data \
      -p 5432:5432 \
      -d \
      postgres:11
  }

  sh command
end

task :droppg, [:sudoer] do |t, args|
  app_env = ENV['APP_ENV'] || 'development'

  container = "yata_#{app_env}"
  dbname    = "yata_#{app_env}"
  username  = "yata"

  root_command = args[:sudoer] ? "sudo docker" : "docker"

  sh "#{root_command} exec -it #{container} dropdb #{dbname} -U #{username}"
  sh "rm -r $HOME/.#{dbname}"

  Rake::Task[:stoppg].invoke
end

task :psql, [:sudoer] do |t, args|
  app_env = ENV['APP_ENV'] || 'development'

  container = "yata_#{app_env}"
  dbname    = "yata_#{app_env}"
  username  = "yata"

  root_command = args[:sudoer] ? "sudo docker" : "docker"

  sh "#{root_command} exec -it #{container} psql #{dbname} -U #{username}"
end

task :stoppg, [:sudoer] do |t, args|
  app_env = ENV['APP_ENV'] || 'development'

  container = "yata_#{app_env}"

  root_command = args[:sudoer] ? "sudo docker" : "docker"

  sh "#{root_command} rm -f #{container}"
end
