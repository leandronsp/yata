task :test do
  ruby "test/app.rb"
end

task :server do
  ruby "./bin/server"
end

task :e2e do
  sh "./bin/test-e2e"
end

task :seed_users do
  users = [
    'test@acme.com;pass123',
    'leandro@acme.com;pass123'
  ]

  File.write('./db/users.txt', users.join("\n"))
end
