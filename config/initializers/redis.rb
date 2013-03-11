$redis = Redis.new(:host => 'localhost', :port => 6379)

uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/")
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
#redis_url = ENV["REDISTOGO_URL"] || "redis://127.0.0.1:6379/0/myapp"
