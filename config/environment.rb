APP_PROTOCOL = ENV['APP_PROTOCOL'] || 'http'
APP_HOST = ENV['APP_HOST'] || 'localhost'
APP_PORT = ENV['APP_PORT'] || 4242
APP_ENV = ENV['APP_ENV'] || 'development'

if APP_ENV != 'production'
  FULL_HOST = "#{APP_PROTOCOL}://#{APP_HOST}:#{APP_PORT}"
else
  FULL_HOST = "#{APP_PROTOCOL}://#{APP_HOST}"
end

